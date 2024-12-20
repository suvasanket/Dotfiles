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
-- }}}

-- Register the user command
create_command("Ftplugin", openftplugin, {})

--qflist
create_command("Clearqflist", function()
	vim.fn.setqflist({})
	vim.cmd("cclose")
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
			print("commited")
		end, function()
			print("error while commit")
		end)

		local remote = vim.api.nvim_exec("G config --get remote.origin.url", true)
		if remote ~= "" then
			local ans = vim.fn.confirm('push to "' .. remote .. '"', "&Yes\n&No")
			if ans == 1 then
				print("pushing to remote...")
				ShellCmd({ "git", "push" }, function()
					print("pushed to " .. remote)
				end, function()
					print("Error pushing")
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
		print("opening " .. vim.fn.expand("%:p:t"))
	end, function()
		print("failed to open")
	end)
end, {})
-- }}}

-- Term {{{
local cachedCmd = nil
create_command("Term", function(args)
	local projectRoot = GetProjectRoot()
	local function run_cached_or_new_term(cmd)
		vim.cmd("cd " .. projectRoot .. " | term " .. (cmd or ""))
	end

	if not args.bang then
		vim.cmd("tabnew")
		if args.args and #args.args > 0 then
			cachedCmd = args.args
			run_cached_or_new_term(cachedCmd)
			vim.cmd("tabp")
		else
			if cachedCmd then
				print("Running cached command: " .. cachedCmd)
				run_cached_or_new_term(cachedCmd)
				vim.cmd("tabp")
			else
				vim.cmd("startinsert")
				run_cached_or_new_term()
			end
		end
	else
		vim.cmd("vsplit | vertical resize 70")
		if args.args and #args.args >= 2 then
			cachedCmd = args.args
			if #args.args == 2 then
				vim.cmd("startinsert")
				run_cached_or_new_term(cachedCmd)
			else
				local ans = vim.fn.confirm("Compile?", "&Yes\n&No")
				if ans == 1 then
					vim.cmd("close")
					vim.cmd("cd " .. projectRoot .. " | Compile " .. cachedCmd)
					vim.cmd("wincmd L | vertical resize 70")
				else
					vim.cmd("startinsert")
					run_cached_or_new_term(cachedCmd)
				end
			end
		else
			run_cached_or_new_term(cachedCmd)
		end
	end
end, { nargs = "*", bang = true })
---}}}
