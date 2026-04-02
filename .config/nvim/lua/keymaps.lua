local ftmap = require("util").ftmap
local map = require("util").map
local cmd = require("util").cmdcr

ftmap("help", "n", "gd", cmd("execute 'help ' . expand('<cword>')"))

map("n", "<leader>qf", cmd("copen"))
map("n", "<leader>qc", function()
	vim.fn.setqflist({})
	vim.cmd("cclose")
end)
map("n", "<leader>j", cmd("t."))
map("n", "<leader>n", function()
	vim.cmd("t.")
	vim.cmd("normal kgcc")
	local pos = vim.api.nvim_win_get_cursor(0)
	pcall(vim.api.nvim_win_set_cursor, 0, pos)
end)
map("n", "<C-;>", ":<up>", { silent = false })
map("i", "<S-CR>", "<esc>O")
map("t", "<C-[>", "<C-\\><C-n>")

map({ "c", "i" }, "<C-a>", "<Home>")
map({ "c", "i" }, "<C-e>", "<End>")
map({ "c", "i" }, "<C-f>", "<Right>")
map({ "c", "i" }, "<C-b>", "<Left>")
map({ "c", "i" }, "<M-f>", "<S-Right>")
map({ "c", "i" }, "<M-b>", "<S-Left>")
map({ "c", "i" }, "<C-d>", "<Del>")
map({ "c", "i" }, "<M-d>", "<S-Right><C-w>")
map({ "c", "i" }, "<C-k>", "<End><C-u>")
map("c", "<C-g>", "<C-f>")
map("c", "<C-l>", function()
	pcall(vim.fn.wildtrigger)
end)

-- paste
map({ "n", "x" }, "gp", function()
	local mode = vim.api.nvim_get_mode()["mode"]
	if not vim.api.nvim_get_current_line():match("^%s*$") and mode == "n" then
		return 'o<esc>"+p`[v`]='
	else
		return '"_c<esc>"+p`[v`]='
	end
end, { expr = true, desc = "clip paste" })

map("n", "gP", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"+p`[v`]='
	else
		return '<esc>O<esc>"+p`[v`]='
	end
end, { expr = true, desc = "clip paste prev" })

map({ "n", "x" }, "p", "p`[v`]=")
map({ "n", "x" }, "P", "P`[v`]=")
map({ "n", "x" }, "gy", '"+y', { desc = "clipboard yank" })
map("x", "<leader>p", [["_dP]], { desc = "blackhole paste" })

map("n", "zx", cmd("bd!"))
map("n", "zh", cmd("tabp"))
map("n", "zl", cmd("tabn"))
map("n", "zL", cmd("tabmove -1"))
map("n", "zH", cmd("tabmove +1"))
map("n", "zo", cmd("tabo"))
map("n", "<leader>R", cmd("restart norm`0"))
map("n", "<C-w>m", "<C-w>|<C-w>_")

map("n", "<C-CR>", function()
	local last_cmd = vim.fn.histget("cmd", -1)
	if not last_cmd:match("Make") then
		last_cmd = "Make"
	end
	vim.cmd(last_cmd)
end)

map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace" })
map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace" })
map("n", "[s", cmd("earlier 1f"))
map("n", "]s", cmd("later 1f"))

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

-- undotree
map("n", "<leader>u", cmd("Undotree"))
