Import("core.helper")

-- quick fix mappings
BufMap("qf", "n", "<C-q>", CMD("Clearqflist"))
BufMap("qf", "n", "c.", [[:cdo s/\<<C-r><C-w>\>//g<Left><Left>]])
BufMap("qf", "n", "c>", [[:cfdo %s/\<<C-r><C-w>\>//g<Left><Left>]])
BufMap("qf", "n", "<C-v>", "<cr><C-w>v<C-w>h<C-o><C-w>l")
BufMap("qf", "n", "dd", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	local qf_list = vim.fn.getqflist()
	local line_num = vim.fn.line(".")
	table.remove(qf_list, line_num)
	vim.fn.setqflist(qf_list, "r")
	vim.cmd("copen")
	local ok = pcall(vim.api.nvim_win_set_cursor, 0, pos)
	if not ok then
		vim.cmd("norm G")
	end
end)
BufMap("qf", "n", "<C-g>", ":cdo ")

-- help
BufMap("help", "n", "gd", "<cmd>execute 'help ' . expand('<cword>')<cr>")
BufMap("man", "n", "gd", "<cmd>execute 'Man ' . expand('<cword>')<cr>")

-- general
Map("n", "<leader>qf", CMD("copen"))
Map("n", "<leader>qc", CMD("Clearqflist"))
Map("n", "<leader>l", CMD("Lazy"))
Map({ "n", "i" }, "<F1>", CMD("silent w!"))
Map("n", "<leader>j", CMD("t."), { desc = "duplicate line" })
Map("n", "<leader>n", function()
	vim.cmd("t.")
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal kgcc")
	pcall(vim.api.nvim_win_set_cursor, 0, pos)
end)
Map("n", "<C-;>", ":<up>", { silent = false })

-- insert mode
Map("i", "<S-CR>", "<esc>O")
Map("i", "<C-k>", "<esc>lC")
Map("i", "<C-l>", "<right>")
Map({ "i", "v" }, "<M-left>", "<C-o>b")
Map({ "i", "v" }, "<M-right>", "<C-o>w")

-- term
Map("t", "<C-[>", "<C-\\><C-n>")
Map("t", "<C-S-\\>", "clear\n")

-- system mappings
Map({ "i", "c" }, "<C-e>", "<end>")
Map({ "i", "c" }, "<C-a>", "<home>")

-- copy paste
Map({ "n", "x" }, "gp", function()
	local mode = vim.api.nvim_get_mode()["mode"]
	if not vim.api.nvim_get_current_line():match("^%s*$") and mode == "n" then
		return 'o<esc>"+p`[v`]='
	else
		return '"_c<esc>"+p`[v`]='
	end
end, { expr = true, desc = "clip paste" })
Map("n", "gP", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"+p`[v`]='
	else
		return '<esc>O<esc>"+p`[v`]='
	end
end, { expr = true, desc = "clip paste prev" })
Map({ "n", "x" }, "]p", ":pu<cr>")
Map({ "n", "x" }, "p", "p`[v`]=")
Map({ "n", "x" }, "P", "P`[v`]=")
Map({ "n", "x" }, "gy", '"+y', { desc = "clipboard yank" })
Map("x", "<leader>p", [["_dP]], { desc = "blackhole paste" })

Map("n", "<C-space>f", CMD("Ftplugin"))

--buffer & tabs
Map("n", "zh", CMD("tabp"))
Map("n", "zl", CMD("tabn"))
Map("n", "zL", CMD("tabmove -1"))
Map("n", "zH", CMD("tabmove +1"))
Map("n", "z]", "mAZZ<C-w>v'A:delmark A<cr>")
Map("n", "z[", "mAZZ:tabp<cr><C-w>v'A:delmark A<cr>")
Map("n", "zo", CMD("tabo"), { desc = "tab only" })

-- window
Map("n", "<C-w>m", "<C-w>|<C-w>_")

-- oz
Map("n", "<leader>gl", CMD("GitLog"))
Map("n", "<leader>ga", CMD("Gw"))
Map("n", "g\\", CMD("Gcw! safe point!"))
-- Map("n", "<leader>gg", CMD("Git commit"))
Map("n", "<C-Cr>", CMD("Make"))

-- Search and Replace
Map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })
Map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })

-- keep visual selection when (de)indenting
Map("v", "<", "<gv", {})
Map("v", ">", ">gv", {})

-- move line
Map("n", "<C-p>", ":m-2<cr>==")
Map("n", "<C-n>", ":m+1<cr>==")
Map("x", "<C-p>", ":m '<-2<CR>gv=gv")
Map("x", "<C-n>", ":m '>+1<CR>gv=gv")

Map("n", "[s", CMD("earlier 1f"))
Map("n", "]s", CMD("later 1f"))

-- grep
Map("n", "gw", ":Grep <C-r><C-w><cr>")
Map("n", "g<cr>", ":Grep 'FIXME|TODO|WIP'<cr>")
Map({ "n", "v" }, "<C-'>", function()
	if vim.fn.mode() == "n" then
		return ":Grep ''<left>"
	elseif vim.fn.mode() == "v" then
		return ":Grep<cr>"
	end
end, { expr = true, silent = false })
