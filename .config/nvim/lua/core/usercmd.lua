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
--misc
create_command("CmpEnable", "lua require('cmp').setup.buffer { enabled = true }")
create_command("CmpDisable", "lua require('cmp').setup.buffer { enabled = false }")

-- luasnip {{{
create_command("LuaSnipOpen", function()
	Import("luasnip.loaders").edit_snippet_files({
		extend = function(ft, paths)
			if #paths == 0 then
				return {
					{ "$CONFIG/" .. ft .. ".lua", string.format("%s/%s.lua", "$HOME/.config/nvim/snippets", ft) },
				}
			end
			return {}
		end,
	})
end)
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

create_command("Echoqflist", function()
	local result = vim.api.nvim_exec("echo len(getqflist())", true)
	print(result)
end)

--history delete
create_command("CmdlineHistoryDel", function()
	vim.fn.histdel(":")
end)

-- Glog
create_command("Glog", function()
	vim.cmd("tabnew")
	vim.cmd("startinsert")
	vim.cmd([[term git lg1]])
	vim.cmd("set ft=fugitive")
end)

-- smart commit push {{{
create_command("Gcommit", function()
	local message = UserInput("commit message: ")
	if message then
		ShellCmd({ "git", "commit", "-am", message }, function()
			Notify("commited", vim.log.levels.INFO, "Git")
		end, function()
			Notify("error while commit", vim.log.levels.ERROR, "Git")
		end)

		local remote = vim.api.nvim_exec("G config --get remote.origin.url", true)
		if remote ~= "" then
			local ans = vim.fn.confirm('push to "' .. remote .. '"', "&Yes\n&No")
			if ans == 1 then
				Notify("pushing to remote...")
				ShellCmd({ "git", "push" }, function()
					Notify("pushed to " .. remote)
				end, function()
					Notify("Error pushing", vim.log.levels.ERROR)
				end)
			end
		end
	end
end)
--}}}

-- GBrowse without plugin {{{
create_command("Gbrowse", function()
	local g_remote = vim.api.nvim_exec("G config --get remote.origin.url", true)
	local url = g_remote:gsub("%.git$", "")
	local branch_name = vim.api.nvim_exec("!git branch -v", true):match("%* (%S+)")
	local g_root = vim.api.nvim_exec("!git rev-parse --show-toplevel", true)
	local git_root = g_root:match("([/][^\r\n]+)"):gsub("\r", "")
	local file_path = vim.fn.expand("%:p")
	local relative_path = file_path:sub(#git_root + 2)

	local repo_url = url .. "/blob/" .. branch_name .. "/" .. relative_path
	ShellCmd({ "open", repo_url }, function()
		Notify("opening " .. vim.fn.expand("%:p:t"), vim.log.levels.INFO, "Git")
	end, function()
		Notify("failed to open", vim.log.levels.ERROR, "Git")
	end)
end)
-- }}}

-- abolish
create_command("AddAbolish", function(opts)
	local args = vim.split(opts.args, " ", { plain = true, trimempty = true })
	if opts.bang then
		vim.cmd("vsplit " .. vim.fn.stdpath("config") .. "/abolish.txt")
		return
	end
	if #args ~= 2 then
		vim.notify("Exactly two arguments are required: <pattern> and <replacement>", vim.log.levels.ERROR)
		return
	end
	Import("core.abolish").add_mapping(args[1], args[2])
end, {
	bang = true,
	nargs = "*",
	desc = "Add a new abolish mapping",
})
