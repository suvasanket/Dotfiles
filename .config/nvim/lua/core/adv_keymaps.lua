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

-- find
local function open_find_with_wildtrigger()
	local group = vim.api.nvim_create_augroup("CmdwinEventsTransient", { clear = true })
    Autocmd("CmdlineChanged", {
		group = group,
		callback = function()
            vim.o.wildmode = "noselect:lastused,full"
			pcall(vim.fn.wildtrigger)
		end,
	})
    Autocmd("CmdlineLeave", {
		group = group,
		once = true,
		callback = function()
			pcall(vim.api.nvim_del_augroup_by_name, "CmdwinEventsTransient")
		end,
	})

	return ":Find "
end

vim.keymap.set("n", "<C-f>", open_find_with_wildtrigger, { expr = true, silent = false })
