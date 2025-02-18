--** Term **--
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
		local spin = "gum spin --spinner moon --title '\nsearching ft:" .. vim.bo.filetype .. " q:" .. input .. " .. ' -- "
		local cht_sh = spin .. "curl cht.sh/" .. vim.bo.filetype
		cht_sh = cht_sh .. "/" .. input:gsub(" ", "+") .. " | gum pager --border none"
		if inside_tmux then
			vim.fn.system("tmux neww -n 'cht.sh' zsh -c \"" .. cht_sh .. '"')
		else
			vim.cmd("tab term " .. cht_sh)
		end
	end
end)

--** Pairs **--
local function getChar(pos)
	local line = vim.api.nvim_get_current_line()
	local cursor_col = vim.fn.col(".")
	if pos == "next" then
		cursor_col = cursor_col + 1 or cursor_col
	elseif pos == "prev" then
		cursor_col = cursor_col - 1
	end
	return cursor_col > 0 and cursor_col <= #line and line:sub(cursor_col, cursor_col) or nil
end
local function GoinsidePair(left, right, func)
	Map("i", right, function()
		if getChar("prev") == left then
			return right .. "<left>"
		else
			return right
		end
	end, { expr = true, silent = false })
	if func then
		func(left, right)
	end
end
GoinsidePair("(", ")", function(leftchar, rightchar)
	Map("i", "<C-h>", function()
		if getChar("prev") == leftchar and getChar() == rightchar then
			return "<right><bs><bs>"
        else
			return "<bs>"
		end
	end, { expr = true })
end)
GoinsidePair('"', '"')
GoinsidePair("'", "'")
GoinsidePair("{", "}")
GoinsidePair("[", "]")

Map("i", "<CR>", function()
	local left = getChar("prev")
	if left == "{" or left == "[" then
		return "<CR><ESC>O"
	else
		return "<CR>"
	end
end, { expr = true })

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
