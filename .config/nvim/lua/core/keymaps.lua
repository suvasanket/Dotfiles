require("core.helper")

-- ** buffer only map (buffer of a specified ft) ** --
BufMap("compilation", "n", "r", CMD("Recompile"))
BufMap("compilation", "n", "<C-d>", CMD("CompileDebugError"))
BufMap("compilation", "n", "<C-q>", CMD("close | QuickfixErrors"))
BufMap("compilation", "n", "]e", CMD("CompileNextError"))
BufMap("compilation", "n", "[e", CMD("CompilePrevError"))
BufMap("compilation", "n", "]f", CMD("CompileNextFile"))
BufMap("compilation", "n", "[f", CMD("CompilePrevFile"))
Map("n", "]e", CMD("NextError"))
Map("n", "[e", CMD("PrevError"))

BufMap("qf", "n", "<C-q>", CMD("Clearqflist"))

-- general
Map("n", "<C-q>", CMD("copen"))
Map("n", "<leader>l", CMD("Lazy"))
Map({ "n", "i" }, "<F1>", CMD("silent w!"))
Map({ "i", "x" }, "<C-c>", "<esc>")
Map("n", "<C-space>", CMD("b #"))
Map("n", "<C-x>", "@:", { desc = "rerun last cmd" })

--abolish
Map("n", "<leader>e", ":AddAbolish ", { desc = "add abolish", silent = false })

-- insert mode
Map("i", "<S-CR>", "<esc>O")
Map("i", "<C-k>", "<esc>lC")
Map("i", "<C-j>", "<esc>:t.<cr>a", { desc = "duplicate line" })
Map("i", "<C-l>", "<right>")

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

-- Term
Map("n", "<leader>tt", CMD("tab term"), { desc = "terminal" })

TerminalCommandType = nil
Map("n", "<leader>at", function()
	local some = UserInput("Term! ")
	if some then
		vim.cmd("Term! " .. some)
		TerminalCommandType = "Term!"
	end
end, { desc = "terminal", silent = false })

Map("n", "<leader>av", function()
	local current_file = vim.fn.expand("%")
	local perCMD = require("core.perCMD")

	local CMD = perCMD.getprojectCMD(current_file:gsub("%.", "_"))
	if not CMD then
		CMD = perCMD.getcompilerCMD(current_file, vim.bo.filetype)
	end

	local input = UserInput(":Term ", CMD)
	if input then
		perCMD.setprojectCMD(current_file:gsub("%.", "_"), input)
        perCMD.setcompilerCMD(vim.bo.filetype, input:gsub(vim.fn.expand("%:r"), "{filename}"))
		vim.cmd("Term " .. input)
	end
	TerminalCommandType = "Term"
end, { desc = "terminal", silent = false })

Map("n", "<leader>aa", function()
	if TerminalCommandType then
		vim.cmd([[w!]])
		vim.cmd(TerminalCommandType)
	end
end)

Map("n", "<leader>sc", function()
	vim.ui.select({ "lang", "utils" }, {
		prompt = "Select cht.sh type",
	}, function(choice)
		if choice == "lang" then
			vim.fn.system("tmux neww -n 'cht.sh' zsh -c '. ~/.local/scripts/cht_sh.sh lang'")
		else
			vim.fn.system("tmux neww -n 'cht.sh' zsh -c '. ~/.local/scripts/cht_sh.sh util'")
		end
	end)
end)
Map("n", "<leader>cs", function()
	local input = UserInput("query:")
	local inside_tmux = os.getenv("TMUX") ~= nil
	if input then
		local spin = "gum spin --spinner moon --title '\n  Searching "
			.. vim.bo.filetype
			.. " "
			.. input
			.. "... ' -- "
		local cht_sh = spin .. "curl cht.sh/" .. vim.bo.filetype
		cht_sh = cht_sh .. "/" .. input:gsub(" ", "+") .. " | gum pager --border none"
		if inside_tmux then
			vim.fn.system("tmux neww -n 'cht.sh' zsh -c \"" .. cht_sh .. '"')
		else
			vim.cmd("tab term " .. cht_sh)
		end
	end
end)

--master
Map("n", "\\f", CMD("Ftplugin"))
Map("n", "\\lq", CMD("LspStop"))
Map("n", "\\ls", CMD("LspStart"))
Map("n", "\\cs", CMD("CmpEnable"))
Map("n", "\\cq", CMD("CmpDisable"))
-- map("n", "\\s", cmd("LuaSnipOpen"))

--buffer & tabs
Map("n", "<leader>_", CMD("split"))
Map("n", "<leader>|", CMD("vsplit"))
Map("t", "<C-[>", "<C-\\><C-n>")
Map("n", "<leader>bf", "Ggqgg", { desc = "buffer format" })
Map("n", "<C-\\>", CMD("q"))
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

Map("n", "[b", CMD("bnext"))
Map("n", "]b", CMD("bprevious"))
Map("n", "zh", CMD("tabp"))
Map("n", "zp", CMD("tabmove -1"))
Map("n", "zl", CMD("tabn"))
Map("n", "zn", CMD("tabmove +1"))
Map("n", "z]", "mAZZ<C-w>v'A:delmark A<cr>")
Map("n", "z[", "mAZZ:tabp<cr><C-w>v'A:delmark A<cr>")
Map("n", "zo", CMD("tabo"), { desc = "tab only" })

-- window
Map("n", "<C-w>m", "<C-w>|<C-w>_")
Map("n", "<C-w>+", "<cmd>resize +10<cr>")
Map("n", "<C-w>-", "<cmd>resize -10<cr>")
Map("n", "<C-w>>", "<cmd>vert resize +10<cr>")
Map("n", "<C-w><", "<cmd>vert resize -10<cr>")

--git
Map("n", "<leader>gg", function()
	local ok = pcall(vim.cmd, "Git")
	if not ok then
		vim.notify("No git repo found", vim.log.levels.ERROR)
		return ":silent Git init | Git"
	end
end, { expr = true })

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
BufMap("fugitive", "n", "gc", function()
	require("mini.extra").pickers.git_commits()
end)
Map("n", "<leader>gc", "<cmd>Gcommit<cr>", { desc = "smart commit" })

--smart-delete
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

--smart-ai
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

-- Search inside visually highlighted text.
Map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search and Replace
Map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })
Map("n", "c>", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false, desc = "search and replace word under cursor" })

-- keep visual selection when (de)indenting
Map("v", "<", "<gv", {})
Map("v", ">", ">gv", {})

-- unimapaired
Map("n", "]<space>", CMD("call append(line('.'), '')"))
Map("n", "[<space>", CMD("call append(line('.')-1, '')"))
Map("n", "]q", CMD("cnext"))
Map("n", "[q", CMD("cprev"))
Map("n", "[s", CMD("earlier 1f"))
Map("n", "]s", CMD("later 1f"))

-- Pairs
local function getChar(pos)
	local line = vim.api.nvim_get_current_line()
	local cursor_col = vim.fn.col(".")
	if pos == "next" then
		cursor_col = cursor_col + 1
	elseif pos == "prev" then
		cursor_col = cursor_col - 1
	end
	return cursor_col > 0 and cursor_col <= #line and line:sub(cursor_col, cursor_col) or nil
end
local function GoinsidePair(left, right, except)
	Map("i", right, function()
		if getChar("prev") == left then
			return right .. "<left>"
		else
			return right
		end
	end, { expr = true, silent = false })
	if except then
		for i = 1, #except do
			Map("i", except[i], function()
				if getChar("prev") == left then
					return "<right>" .. except[i]
				else
					return except[i]
				end
			end, { expr = true })
		end
	end
end
GoinsidePair("(", ")", { "<space>", ":" })
GoinsidePair('"', '"')
GoinsidePair("'", "'")
GoinsidePair("{", "}")
GoinsidePair("[", "]")

local function delPair(left, right)
	Map("i", "<C-h>", function()
		local leftchar = getChar("prev") -- Get the character to the left of the cursor
		local rightchar = getChar() -- Get the character at the cursor position
		if left == leftchar and right == rightchar then
			return "<right><bs><bs>" -- Move right, then delete both characters
		else
			return "<bs>" -- Default backspace behavior
		end
	end, { expr = true })
end

delPair("(", ")")
Map("i", "<CR>", function()
	local left = getChar("prev")
	if left == "{" or left == "[" then
		return "<CR><ESC>O"
	else
		return "<CR>"
	end
end, { expr = true })
