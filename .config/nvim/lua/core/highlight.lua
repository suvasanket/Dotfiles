local hi = function(name, val, id)
	local defaultid = 0
	if id then
		defaultid = id
	end
	vim.api.nvim_set_hl(defaultid, name, val)
end
local batchHl = function(hl_group, id)
	local highlights = vim.fn.getcompletion(hl_group, "highlight") -- Get all highlight groups starting with "Normal"
	for _, name in ipairs(highlights) do
		vim.api.nvim_set_hl(0, name, id) -- Set the background to NONE
	end
end

Autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		hi("Folded", { fg = "#7D7C7C" })
		hi("Search", { link = "IncSearch" })

		hi("TreesitterContext", { link = "CursorLine" })

		hi("hlyank", { bg = "#FF9B50" })
		hi("NormalFloat", { link = "Normal" })
		hi("FloatBorder", { bg = "NONE" })


		hi("PmenuSel", { bg = "#282C34", fg = "NONE", bold = true })
		hi("Pmenu", { bg = "#222222" })

		--fleet
        hi("Normal", { fg = "#CCCCCC" })
        hi("Comment", { fg = "#909090", italic = true })
        hi("SignColumn", { bg = "NONE" })
		hi("TabLineSel", { bg = "NONE", bold = true })
		hi("TabLine", { bg = "#202020" })
		hi("@string", { fg = "#80AF81" })
		hi("Visual", { bg = "#202020" })
		hi("WinSeparator", { link = "FloatBorder" })
		hi("WhichKeyNormal", { link = "CursorLine" })
		hi("StatusLineNC", { bg = "#202020", fg = "#BBBBBB" })
		hi("MiniStatuslineModeNormal", { bold = true })
        hi("MiniPickPrompt", { link = "Normal" })

		batchHl("DiagnosticError", { bg = "NONE", fg = "#eb5f61" })
		batchHl("DiagnosticWarn", { bg = "NONE", fg = "#ee7f25" })
		batchHl("DiagnosticInfo", { bg = "NONE" })
		batchHl("DiagnosticHint", { bg = "NONE" })
	end,
})

--highlight yank
Augroup("yank", { clear = true })
Autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "hlyank", timeout = 70 })
	end,
	group = "yank",
})
