-- vim: foldmethod=marker
-- vim: foldlevel=0
-- configs {{{
---@diagnostic disable: need-check-nil
---@diagnostic disable: lowercase-global
local create_command = function(name, action, opts)
	if opts then
		vim.api.nvim_create_user_command(name, action, opts)
	else
		vim.api.nvim_create_user_command(name, action, {})
	end
end
---@diagnostic disable-next-line: unused-local
local ex = vim.fn.expand
pwd = vim.fn.expand("%:p:h")
file = vim.fn.expand("%:t")
filewe = vim.fn.expand("%:t:r")

local function sh(cmd)
	local zhs = table.concat({ "!", cmd })
	vim.cmd(zhs)
end
--}}}

-- ftplugin {{{
local function openftplugin()
	local filepath = vim.fn.stdpath("config") .. "/ftplugin/" .. vim.bo.filetype .. ".lua"
	if not vim.fn.filereadable(filepath) then
		vim.fn.mkdir(vim.fn.stdpath("config") .. "/ftplugin", "p")
		vim.fn.writefile({}, filepath)
	end
	vim.cmd("vsplit " .. filepath)
end

-- Register the user command
create_command("Ftplugin", openftplugin)
-- }}}

--qflist
create_command("Clearqflist", function()
	vim.fn.setqflist({})
	vim.cmd("cclose")
	Notify("quickfix list emptied")
end)
