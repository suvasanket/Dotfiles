-- vim: foldmethod=marker
-- vim: foldlevel=0
--{{{
---@diagnostic disable: need-check-nil
---@diagnostic disable: lowercase-global
local create_command = vim.api.nvim_create_user_command
local ex = vim.fn.expand
pwd = vim.fn.expand("%:p:h")
file = vim.fn.expand("%:t")
filewe = vim.fn.expand("%:t:r")

local function term(cmd)
	local ter = table.concat({ "split | resize 15 | term ", cmd })
	vim.cmd(ter)
end

local function sh(cmd)
	local zhs = table.concat({ "!", cmd })
	vim.cmd(zhs)
end
--}}}
--misc
create_command("CmpEnable", "lua require('cmp').setup.buffer { enabled = true }", {})
create_command("CmpDisable", "lua require('cmp').setup.buffer { enabled = false }", {})

-- luasnip {{{
create_command("LuaSnipOpen", function()
	require("luasnip.loaders").edit_snippet_files({
		extend = function(ft, paths)
			if #paths == 0 then
				return {
					{ "$CONFIG/" .. ft .. ".lua", string.format("%s/%s.lua", "$HOME/.config/nvim/snippets", ft) },
				}
			end
			return {}
		end,
	})
end, {})
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
create_command("Ftplugin", openftplugin, {})
-- }}}

--qflist
create_command("Clearqflist", function()
	vim.fn.setqflist({})
	vim.cmd("cclose")
	Notify("quickfix list emptied")
end, {})

create_command("Echoqflist", function()
	local result = vim.api.nvim_exec("echo len(getqflist())", true)
	print(result)
end, {})

--history delete
create_command("CmdlineHistoryDel", function()
	vim.fn.histdel(":")
end, {})

-- Glog
create_command("Glog", function()
	vim.cmd("tabnew")
	vim.cmd("startinsert")
	vim.cmd([[term git lg1]])
	vim.cmd("set ft=fugitive")
end, {})

-- smart commit push {{{
create_command("Gcommit", function()
	local message = vim.fn.input("commit message: ")
	if message ~= "" then
		ShellCmd({ "git", "commit", "-am", message }, function()
			Notify("commited", "INFO", "Git")
		end, function()
			Notify("error while commit", "ERROR", "Git")
		end)

		local remote = vim.api.nvim_exec("G config --get remote.origin.url", true)
		if remote ~= "" then
			local ans = vim.fn.confirm('push to "' .. remote .. '"', "&Yes\n&No")
			if ans == 1 then
				Notify("pushing to remote...")
				ShellCmd({ "git", "push" }, function()
					Notify("pushed to " .. remote)
				end, function()
					Notify("Error pushing", "ERROR")
				end)
			end
		end
	end
end, {})
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
		Notify("opening " .. vim.fn.expand("%:p:t"), nil, "Git")
	end, function()
		Notify("failed to open", "ERROR", "Git")
	end)
end, {})
-- }}}

-- Term {{{
local cachedCmd = nil
create_command("Term", function(args)
	local projectRoot = GetProjectRoot()
	local function run_cached_or_new_term(cmd)
		if cmd then
			local some = "cd " .. projectRoot .. " && " .. cmd
			vim.fn.system("tmux neww -n 'Term!' -d " .. "'" .. some .. "'")
			vim.notify("Executing " .. cmd .. "...")
		end
	end

	if args.bang then
		if args.args and #args.args > 0 then
			cachedCmd = args.args
			run_cached_or_new_term(cachedCmd)
		else
			run_cached_or_new_term(cachedCmd)
		end
	else
		if args.args and #args.args >= 2 then
			cachedCmd = args.args
		end
		if cachedCmd then
			vim.cmd("vsplit | vertical resize 70")
			vim.cmd("wincmd L | vertical resize 70")
			vim.cmd("startinsert")
			vim.cmd("term " .. cachedCmd)
			vim.notify("Executing " .. cachedCmd .. "...")
		end
	end
end, { nargs = "*", bang = true })
---}}}
