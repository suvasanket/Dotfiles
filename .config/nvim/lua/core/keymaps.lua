Import("core.helper")

-- help
BufMap("help", "n", "gd", "<cmd>execute 'help ' . expand('<cword>')<cr>")
BufMap("man", "n", "gd", "<cmd>execute 'Man ' . expand('<cword>')<cr>")

-- general
Map("n", "<leader>qf", CMD("copen"))
Map("n", "<leader>qc", CMD("Clearqflist"))
Map("n", "<leader>l", CMD("Lazy"))
Map("n", "<leader>j", CMD("t."), { desc = "duplicate line" })
Map("n", "<leader>n", function()
	vim.cmd("t.")
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal kgcc")
	pcall(vim.api.nvim_win_set_cursor, 0, pos)
end)
Map("n", "<C-;>", ":<up>", { silent = false })
Map("i", "<S-CR>", "<esc>O")
Map("t", "<C-[>", "<C-\\><C-n>")

-- cmdline
vim.keymap.set("c", "<C-l>", function()
	pcall(vim.fn.wildtrigger)
end)
vim.keymap.set({ "c", "i" }, "<C-a>", "<Home>")
vim.keymap.set({ "c", "i" }, "<C-e>", "<End>")
vim.keymap.set({ "c", "i" }, "<C-f>", "<Right>")
vim.keymap.set({ "c", "i" }, "<C-b>", "<Left>")
vim.keymap.set({ "c", "i" }, "<M-f>", "<S-Right>")
vim.keymap.set({ "c", "i" }, "<M-b>", "<S-Left>")
vim.keymap.set({ "c", "i" }, "<C-d>", "<Del>")
vim.keymap.set({ "c", "i" }, "<M-d>", "<S-Right><C-w>")
vim.keymap.set({ "c", "i" }, "<C-k>", "<End><C-u>")
vim.keymap.set("c", "<C-g>", "<C-f>")

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

--buffer & tabs
Map("n", "zx", CMD("bd!"))
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
Map("n", "<C-Cr>", function()
	local last_cmd = vim.fn.histget("cmd", -1)
	if not last_cmd:match("Make") then
		last_cmd = "Make"
	end
	vim.cmd(last_cmd)
end)

-- Search and Replace
Map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })
Map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })

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

--** Basic Smart things **--
Map("n", "i", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return "cc"
	else
		return "i"
	end
end, { expr = true })
Map("n", "a", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return "cc"
	else
		return "a"
	end
end, { expr = true })

Map("n", "dd", function()
	local line_data = vim.api.nvim_win_get_cursor(0)
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)
	if current_line[1] == "" then
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true })

Map("n", "cc", function()
	local line_data = vim.api.nvim_win_get_cursor(0)
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)
	if current_line[1] == "" then
		return '"_cc'
	else
		return "cc"
	end
end, { expr = true })

BufMap("oil", "n", "=", function()
	if vim.fn.executable("zoxide") == 0 then
		vim.notify("zoxide not found in PATH", vim.log.levels.ERROR)
		return
	end

	local command_output = vim.fn.system("zoxide query -l")
	local paths = vim.split(command_output, "\n", { trimempty = true })

	vim.ui.select(paths, {
		prompt = "zoxide entry",
	}, function(choice)
		if choice then
			vim.cmd("edit " .. choice)
		end
	end)
end)

Map("n", "zo", function()
	local visible_bufs = {}
	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
			local buf = vim.api.nvim_win_get_buf(win)
			visible_bufs[buf] = true
		end
	end

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if not visible_bufs[buf] then
			pcall(vim.api.nvim_buf_delete, buf, { force = false })
		end
	end

	vim.notify("Closed hidden buffers")
end)

-- find file --
vim.keymap.set("n", "<C-f>", ":Find ")
