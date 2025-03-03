Import("core.helper")

-- ** buffer only map (buffer of a specified ft) ** --
BufMap("compilation", "n", "r", CMD("Recompile"))
BufMap("compilation", "n", "<C-d>", CMD("CompileDebugError"))
BufMap("compilation", "n", "]e", CMD("CompileNextError"))
BufMap("compilation", "n", "[e", CMD("CompilePrevError"))
BufMap("compilation", "n", "]f", CMD("CompileNextFile"))
BufMap("compilation", "n", "[f", CMD("CompilePrevFile"))
Map("n", "]e", CMD("NextError"))
Map("n", "[e", CMD("PrevError"))

BufMap("qf", "n", "<C-q>", CMD("Clearqflist"))
BufMap("qf", "n", "c.", [[:cdo s/\<<C-r><C-w>\>//g<Left><Left>]])
BufMap("qf", "n", "c>", [[:cfdo %s/\<<C-r><C-w>\>//g<Left><Left>]])
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

-- general
Map("n", "<leader>qf", CMD("copen"))
Map("n", "<leader>qc", CMD("Clearqflist"))
Map("n", "<leader>l", CMD("Lazy"))
Map({ "n", "i" }, "<F1>", CMD("silent w!"))
Map({ "i", "x" }, "<C-c>", "<esc>")
Map("n", "<C-;>", "@:", { desc = "rerun last cmd" })
Map("n", "<leader>j", CMD("t."), { desc = "duplicate line" })
Map("n", "<leader>n", function()
	vim.cmd("t.")
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal kgcc")
	pcall(vim.api.nvim_win_set_cursor, 0, pos)
end)

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
Map("x", "<D-p>", [["_dP]], { desc = "blackhole paste" })

--master
Map("n", "<C-space>f", CMD("Ftplugin"))
Map("n", "<C-space>lq", CMD("LspStop"))
Map("n", "<C-space>ls", CMD("LspStart"))
Map("n", "<C-space>aa", ":AddAbolish ", { desc = "add abolish", silent = false })
Map("n", "<C-space>ae", ":AddAbolish!<cr>", { desc = "edit abolish", silent = false })

--buffer & tabs
Map("n", "[b", CMD("bnext"))
Map("n", "]b", CMD("bprevious"))
Map("n", "zp", CMD("tabp"))
Map("n", "zn", CMD("tabn"))
Map("n", "zP", CMD("tabmove -1"))
Map("n", "zN", CMD("tabmove +1"))
Map("n", "z]", "mAZZ<C-w>v'A:delmark A<cr>")
Map("n", "z[", "mAZZ:tabp<cr><C-w>v'A:delmark A<cr>")
Map("n", "zo", CMD("tabo"), { desc = "tab only" })

-- window
Map("n", "<C-w>m", "<C-w>|<C-w>_")
Map("n", "<C-w>+", "<cmd>resize +10<cr>")
Map("n", "<C-w>-", "<cmd>resize -10<cr>")
Map("n", "<C-w>>", "<cmd>vert resize +7<cr>")
Map("n", "<C-w><", "<cmd>vert resize -7<cr>")

--git
Map("n", "<leader>gg", function()
	local ok = pcall(vim.cmd, "G")
	if not ok then
		vim.notify("No git repo found", vim.log.levels.ERROR)
		vim.api.nvim_feedkeys(":silent Git init | Git", "n", false)
	end
end, { silent = false })

BufMap("fugitive", "n", "gm", function()
	local user_input = UserInput("remote url: ")
	if user_input then
		ShellCmd({ "git", "remote", "add", "origin", user_input }, function()
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
BufMap("fugitive", "n", "K", function()
	local line = vim.fn.getline(".")
	local pattern = line:match("^%S*%s(.+)$")
	vim.cmd("G rm --cached -r " .. pattern)
end)
Map("n", "<leader>gc", "<cmd>Gcommit<cr>", { desc = "smart commit" })

-- Search inside visually highlighted text.
Map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search and Replace
Map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })
Map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })

-- keep visual selection when (de)indenting
Map("v", "<", "<gv", {})
Map("v", ">", ">gv", {})

-- move line
Map("n", "<C-p>", ":m-2<cr>==")
Map("n", "<C-n>", ":m+1<cr>==")

-- unimapaired
Map("n", "]<space>", CMD("call append(line('.'), '')"))
Map("n", "[<space>", CMD("call append(line('.')-1, '')"))
Map("n", "]q", CMD("cnext"))
Map("n", "[q", CMD("cprev"))
Map("n", "[s", CMD("earlier 1f"))
Map("n", "]s", CMD("later 1f"))
Map("n", "[t", CMD("tabp"))
Map("n", "]t", CMD("tabn"))
