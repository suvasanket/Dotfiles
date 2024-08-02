require("core.helper")

-- ** buffer only map (buffer of a specified ft) ** --
bufmap("compilation", "n", "n", cmd("NextError"))
bufmap("compilation", "n", "p", cmd("PrevError"))
bufmap("compilation", "n", "r", cmd("Recompile"))
bufmap("compilation", "n", "<C-r>", cmd("Recompile"))
bufmap("compilation", "n", "u", "gg")

bufmap("trouble", "n", "<C-q>", cmd("Clearqflist"))

-- general
map("n", "<tab>", "za")
map("n", "<S-tab>", "zi")
map("n", "<esc>", ":noh<cr><esc>")
map("n", "zx", cmd("bd!"))
map("n", "<leader>l", cmd("Lazy"))
map({ "n", "i" }, "<F1>", cmd("silent w!"))
map("n", "<leader>tt", cmd("split|resize 15|term"), { desc = "terminal" })
map("n", "<C-q>", function()
	local result = vim.fn.len(vim.fn.getqflist())
	if result ~= 0 then
		vim.cmd("Trouble quickfix")
		print(result)
	else
		print("Quickfix is empty")
	end
end, { desc = "quickfix open" })

-- insert mode
map("i", "<S-CR>", "<C-c>O")
map("i", "<C-l>", "<right>")
map("i", "<C-k>", "<up>")
map("i", "<C-j>", "<down>")
map("i", "<C-h>", "<left>")

-- system mappings
map({"i", "c"}, "<C-e>", "<end>")
map({"i", "c"}, "<C-a>", "<home>")

-- copy paste
map({ "n", "x" }, "gp", function()
	local mode = vim.api.nvim_get_mode()["mode"]
	if not vim.api.nvim_get_current_line():match("^%s*$") and mode == "n" then
		return 'o<esc>"+p`[v`]='
	else
		return '"+p`[v`]='
	end
end, { expr = true, desc = "clip paste" })
map({ "n", "x" }, "gP", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"+p`[v`]='
	else
		return '<esc>O<esc>"+p`[v`]='
	end
end, { expr = true, desc = "clip paste prev" })
map({ "n", "x" }, "]p", ":pu<cr>")
map({ "n", "x" }, "p", "p`[v`]=")
map({ "n", "x" }, "P", "P`[v`]=")
map({ "n", "x" }, "gy", '"+y', { desc = "clipboard yank" })
map("x", "p", [["_dP]], { desc = "blackhole paste" })

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
map("n", "<C-\\>", cmd("q"))
map("n", "<leader>1", "1gt", { desc = "tab 1" })
map("n", "<leader>2", "2gt", { desc = "tab 2" })
map("n", "<leader>3", "3gt", { desc = "tab 3" })
map("n", "<leader>4", "4gt", { desc = "tab 4" })
map("n", "<leader>5", "5gt", { desc = "tab 5" })

map("n", "zn", cmd("bnext"))
map("n", "zp", cmd("bprevious"))
map("n", "<C-p>", cmd("tabp"))
map("n", "<C-n>", cmd("tabn"))
map("n", "<C-e>", "<C-^>")

--git
bufmap("fugitive", "n", "gm", "<cmd>GremoteUrl<cr>")
bufmap("fugitive", "n", "x", "<cmd>GitDeleteCached<cr>")
bufmap("fugitive", "n", "gc", cmd_tele("git_commits"))
map( "n", "<leader>gc", "<cmd>Gcommit<cr>", { desc = "smart commit" } )

--smart-delete
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
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })
map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })

--copied from prime
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("i", "<C-c>", "<esc>")

-- project smart find_file
map("n", "<leader>.", function()
	local workspace = vim.lsp.buf.list_workspace_folders()
	local wd = ""
	if workspace[1] ~= nil then
		wd = workspace[#workspace]
	else
		wd = vim.fn.getcwd()
	end
	local cd_pro = "cd " .. wd .. " | "

	local search = "Telescope frecency workspace=CWD"
	local op1 = "prompt_title=false preview_title=false result_title=false"
	local op2 = "layout_config={preview_width=0.5} prompt_prefix=\\ 󱝩\\ "
	vim.fn.timer_start(5000, function()
		vim.cmd("echo ''")
	end)

	return "<cmd>" .. cd_pro .. " " .. search .. " " .. op1 .. " " .. op2 .. "<cr>"
end, { expr = true, desc = "project files" })

-- line move in normal and visual
map("n", "J", ":m .+1<CR>==")
map("n", "K", ":m .-2<CR>==")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "H", "<<")
map("n", "L", ">>")

-- unimapaired
map("n", "]<space>", cmd("call append(line('.'), '')"))
map("n", "[<space>", cmd("call append(line('.')-1, '')"))
