local M = {}
local set_hl = function(group, options)
	local bg = options.bg == nil and "" or "guibg=" .. options.bg
	local fg = options.fg == nil and "" or "guifg=" .. options.fg
	local gui = options.gui == nil and "" or "gui=" .. options.gui

	vim.cmd(string.format("hi %s %s %s %s", group, bg, fg, gui))
end

local highlights = {
	{ "Mode", { bg = "#6e6f70", fg = "#000000", gui = "bold" } },
	{ "StatusLineNC", { fg = "#555555", bg = "#1a1a1a" } },
	{ "StatusLine", { fg = "#555555", bg = "#1a1a1a" } },
	{ "LineCol", { bg = "#6e6f70", fg = "#000000", gui = "bold" } },
	{ "Git", { bg = "#1a1a1a", fg = "#555555" } },
	{ "Filetype", { bg = "#1a1a1a", fg = "#555555" } },
	{ "Filename", { bg = "#1a1a1a", fg = "#555555" } },
}

for _, highlight in ipairs(highlights) do
	set_hl(highlight[1], highlight[2])
end

vim.o.laststatus = 2
local fn = vim.fn
local api = vim.api

-- possible values are 'arrow' | 'rounded' | 'blank'
local active_sep = "blank"

M.separators = {
	arrow = { "", "" },
	rounded = { "", "" },
	blank = { "", "" },
}

-- highlight groups
M.colors = {
	active = "%#StatusLine#",
	inactive = "%#StatuslineNC#",
	mode = "%#Mode#",
	mode_alt = "%#ModeAlt#",
	git = "%#Git#",
	git_alt = "%#GitAlt#",
	filetype = "%#Filetype#",
	filetype_alt = "%#FiletypeAlt#",
	line_col = "%#LineCol#",
	line_col_alt = "%#LineColAlt#",
}

M.trunc_width = setmetatable({
	mode = 80,
	git_status = 90,
	filename = 140,
	line_col = 60,
}, {
	__index = function()
		return 80
	end,
})

M.is_truncated = function(_, width)
	local current_width = api.nvim_win_get_width(0)
	return current_width < width
end

M.modes = setmetatable({
	["n"] = { "Normal", "N" },
	["no"] = { "N·Pending", "N·P" },
	["v"] = { "Visual", "V" },
	["V"] = { "V·Line", "V·L" },
	[""] = { "V·Block", "V·B" }, -- this is not ^V, but it's , they're different
	["s"] = { "Select", "S" },
	["S"] = { "S·Line", "S·L" },
	[""] = { "S·Block", "S·B" }, -- same with this one, it's not ^S but it's 
	["i"] = { "Insert", "I" },
	["ic"] = { "Insert", "I" },
	["R"] = { "Replace", "R" },
	["Rv"] = { "V·Replace", "V·R" },
	["c"] = { "Command", "C" },
	["cv"] = { "Vim·Ex ", "V·E" },
	["ce"] = { "Ex ", "E" },
	["r"] = { "Prompt ", "P" },
	["rm"] = { "More ", "M" },
	["r?"] = { "Confirm ", "C" },
	["!"] = { "Shell ", "S" },
	["t"] = { "Terminal ", "T" },
}, {
	__index = function()
		return { "Unknown", "U" } -- handle edge cases
	end,
})

M.get_current_mode = function(self)
	local current_mode = api.nvim_get_mode().mode

	if self:is_truncated(self.trunc_width.mode) then
		return string.format(" %s ", self.modes[current_mode][2])
	end
	return string.format(" %s ", self.modes[current_mode][1])
end

M.get_git_status = function(self)
	-- use fallback because it doesn't set this variable on the initial `BufEnter`
	local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
	local is_head_empty = signs.head ~= ""

	if self:is_truncated(self.trunc_width.git_status) then
		return is_head_empty and string.format("  %s ", signs.head or "") or ""
	end

	return is_head_empty and string.format("  %s ", signs.head) or ""
end

M.lsp_diagnostics = function(self)
	local result = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		result[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	if self:is_truncated(120) then
		return ""
	else
		return string.format(
			"   %s   %s ",
			result["errors"] or 0,
			result["warnings"] or 0,
			result["info"] or 0,
			result["hints"] or 0
		)
	end
end

M.get_filename = function(self)
	local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
	local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })

	if self:is_truncated(self.trunc_width.filename) then
		return string.format("%s", icon) .. " %<%f"
	end
	return string.format("%s", icon) .. " %<%F"
end

M.get_line_col = function(self)
	if self:is_truncated(self.trunc_width.line_col) then
		return " %p%% "
	end
	return "  %p%%  "
end

M.set_active = function(self)
	local colors = self.colors

	local mode = colors.mode .. self:get_current_mode()
	local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
	local git = colors.git .. self:get_git_status()
	local git_alt = colors.git_alt .. self.separators[active_sep][1]
	local filename = colors.inactive .. self:get_filename()
	local filetype = colors.filetype .. self:lsp_diagnostics()
	local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
	local line_col = colors.line_col .. self:get_line_col()
	local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

	return table.concat({
		colors.active,
		mode,
		mode_alt,
		git,
		git_alt,
		"%=",
		filename,
		"%=",
		filetype,
		filetype_alt,
		line_col_alt,
		line_col,
	})
end

M.set_inactive = function(self)
	local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
	local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })

	if self:is_truncated(self.trunc_width.filename) then
		return "%=" .. string.format("%s", icon) .. " %<%f%="
	end
	return "%=" .. string.format("%s", icon) .. "%<%F%="
end

Statusline = setmetatable(M, {
	__call = function(statusline, mode)
		if mode == "active" then
			return statusline:set_active()
		end
		if mode == "inactive" then
			return statusline:set_inactive()
		end
	end,
})

api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  augroup END
]],
	false
)
