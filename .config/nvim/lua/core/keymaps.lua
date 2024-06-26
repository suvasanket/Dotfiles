--{{{
-- vim: foldmethod=marker
-- vim: foldlevel=0
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

local function cmd(command)
	return table.concat({ "<Cmd>", command, "<CR>" })
end
local filetypemap = require("core.filetype_keymap")
--}}}

--general
map("n", "<tab>", "za")
map("n", "<S-tab>", "zi")
map("n", "<leader>l", cmd("Lazy"))
map("n","<C-S>",cmd("w!"))
map({ "n", "x" }, "gp", '"+p', { desc = "clipboard paste" })
map({ "n", "x" }, "gy", '"+y', { desc = "clipboard yank" })
map("n", "<leader>tt", cmd("split|resize 15|term"), { desc = "terminal" })
map({ "x", "n" }, "<leader>p", [["_dP]], { desc = "blackhole paste" })
map("n", "<C-q>", function()
	local result = vim.fn.len(vim.fn.getqflist())
	if result ~= 0 then
		vim.cmd("Trouble quickfix")
		print(result)
	else
		print("Quickfix is empty")
	end
end, { desc = "quickfix open" })
map("n", "H", "<C-o>")
map("n", "L", "<C-i>")

--ftmap

--master
map("n", "\\s", cmd("LuaSnipOpen"))
map("n", "\\f", cmd("Ftplugin"))
map("n", "\\lq", cmd("LspStop"))
map("n", "\\ls", cmd("LspStart"))
map("n", "\\cs", cmd("CmpEnable"))
map("n", "\\cq", cmd("CmpDisable"))

--buffer & tabs
map("n", "<leader>_", cmd("split"))
map("n", "<leader>|", cmd("vsplit"))
map("t", "<C-[>", "<C-\\><C-n>")
map("n", "<C-t>", cmd("tabnew"))
map("n", "<leader>bf", "gg=G<C-o>", { desc = "buffer format" })
-- map("n", "<C-\\>", cmd("q"))

map("n", "zn", cmd("bnext"))
map("n", "zp", cmd("bprevious"))
map("n", "<C-p>", cmd("tabp"))
map("n", "<C-n>", cmd("tabn"))
map("n", "<C-e>", "<C-^>")

--git
map(
	"n",
	"<leader>gl",
	'<cmd>lcd%:p:h<cr><cmd>lua require("lazy.util").float_term({ "lazygit" }, { interactive = true })<cr>',
	{ desc = "lazygit" }
)
map("n", "<leader>gr", function()
	local user_input = vim.fn.input("url:")
	vim.cmd("G remote add origin " .. user_input)
end, { desc = "git add remote" })

--smart-dele
map("n", "dd", function()
	local line_data = vim.api.nvim_win_get_cursor(0)
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)
	if current_line[1] == "" then
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true })

map("n", "cc", function()
	local line_data = vim.api.nvim_win_get_cursor(0)
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)
	if current_line[1] == "" then
		return '"_cc'
	else
		return "cc"
	end
end, { expr = true })

--smart-ai
map("n", "i", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return "cc"
	else
		return "i"
	end
end, { expr = true })
map("n", "a", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return "cc"
	else
		return "a"
	end
end, { expr = true })

-- keep visual selection when (de)indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- Search inside visually highlighted text.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search and Replace
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "search and replace word under cursor" })
map("n", "c>", [[:%s/\V<C-r><C-a>//g<Left><Left>]], { desc = "search and replace WORD under cursor" })
map("x", "c.", [[:<C-u>%s/\V<C-r>=luaeval("require'utils'.get_visual_selection(true)")<CR>//g<Left><Left>]])

--copied from prime
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("i", "<C-c>", "<esc>")
