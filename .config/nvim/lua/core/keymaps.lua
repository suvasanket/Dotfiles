require("core.helper")

-- ** buffer only map (buffer of a specified ft) ** --
bufmap("compilation", "n", "n", cmd("NextError"))
bufmap("compilation", "n", "p", cmd("PrevError"))
bufmap("compilation", "n", "r", cmd("Recompile"))
bufmap("compilation", "n", "<C-r>", cmd("Recompile"))
bufmap("compilation", "n", "u", "gg")

bufmap("qf", "n", "<C-q>", cmd("Clearqflist"))

-- general
map("n", "<C-q>", cmd("copen"))
map("n", "zx", cmd("bd!"))
map("n", "<leader>l", cmd("Lazy"))
map({ "n", "i" }, "<F1>", cmd("silent w!"))
map("i", "<C-j>", "<esc>:t.<cr>a", { desc = "duplicate line" })
map({ "i", "x" }, "<C-c>", "<esc>")
map("n", "<C-space>", cmd("b #"))
map("n", "<leader>tt", cmd("tabnew|term"), { desc = "terminal" })

-- insert mode
map("i", "<S-CR>", "<esc>O")
map("i", "<C-k>", "<esc>lC")

-- system mappings
map({ "i", "c" }, "<C-e>", "<end>")
map({ "i", "c" }, "<C-a>", "<home>")

-- copy paste
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
map({ "n", "x" }, "]p", ":pu<cr>")
map({ "n", "x" }, "p", "p`[v`]=")
map({ "n", "x" }, "P", "P`[v`]=")
map({ "n", "x" }, "gy", '"+y', { desc = "clipboard yank" })
map("x", "<D-p>", [["_dP]], { desc = "blackhole paste" })

--master
-- map("n", "\\s", cmd("LuaSnipOpen"))
map("n", "\\f", cmd("Ftplugin"))
map("n", "\\lq", cmd("LspStop"))
map("n", "\\ls", cmd("LspStart"))
map("n", "\\cs", cmd("CmpEnable"))
map("n", "\\cq", cmd("CmpDisable"))

--buffer & tabs
map("n", "<leader>_", cmd("split"))
map("n", "<leader>|", cmd("vsplit"))
map("t", "<C-[>", "<C-\\><C-n>")
map("n", "<leader>bf", "Ggqgg<c-o>", { desc = "buffer format" })
map("n", "<C-\\>", cmd("q"))

map("n", "zn", cmd("bnext"))
map("n", "zp", cmd("bprevious"))
map("n", "<C-h>", cmd("tabp"))
map("n", "<C-l>", cmd("tabn"))

--git
bufmap("fugitive", "n", "gm", function()
	local user_input = vim.fn.input("remote url: ")
	if user_input ~= "" then
		shell_cmd({ "git", "remote", "add", "origin", user_input }, function()
			print("remote added")
		end, function()
			local ans = vim.fn.confirm("DO you really want to update remote url ?", "&Yes\n&No")
			if ans == 1 then
				vim.cmd("Git remote set-url origin " .. user_input)
				print("git remote set to " .. user_input)
			end
		end)
	end
end)
bufmap("fugitive", "n", "K", function()
	local line = vim.fn.getline(".")
	local pattern = line:match("^%S*%s(.+)$")
	vim.cmd("G rm --cached -r " .. pattern)
end)
bufmap("fugitive", "n", "gc", cmd_tele("git_commits"))
map("n", "<leader>gc", "<cmd>Gcommit<cr>", { desc = "smart commit" })

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

-- Search inside visually highlighted text.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search and Replace
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })
map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })

-- line move in normal and visual
-- map("n", "J", ":m .+1<CR>==")
-- map("n", "K", ":m .-2<CR>==")
-- map("v", "J", ":m '>+1<CR>gv=gv")
-- map("v", "K", ":m '<-2<CR>gv=gv")
-- map("x", "H", "<gv")
-- map("x", "L", ">gv")
-- map("n", "H", "<<")
-- map("n", "L", ">>")

-- keep visual selection when (de)indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- unimapaired
map("n", "]<space>", cmd("call append(line('.'), '')"))
map("n", "[<space>", cmd("call append(line('.')-1, '')"))
map("n", "]q", cmd("cnext"))
map("n", "[q", cmd("cprev"))
