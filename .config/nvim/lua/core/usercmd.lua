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

----scripts----
--[[
	1.in scripts name of the script
	2.make a function to be execute if selected the script name
	3.call the script within a if statement
	*term() for execute in term
	*sh() for execute in sh in backend
]]

scripts = { "javac", "cdebug" }
local function javac()
	local cwd = ex("%:p:h")
	local file = ex("%:t")
	local filewe = ex("%:t:r")
	local shit = "cd " .. cwd .. " && javac " .. file .. " && java " .. filewe .. " && rm " .. filewe .. ".class"
	term(shit)
end

local function clang()
	local file = ex("%:t")
	local filewe = ex("%:t:r")
	sh("clang --debug " .. file .. " -o " .. filewe)
end

--run
create_command("Runy", function()
	vim.ui.select(scripts, {
		prompt = "Scripts",
	}, function(choice)
		----scripts call----
		if choice == "javac" then
			javac()
		elseif choice == "cdebug" then
			clang()
		else
			vim.cmd("echo'done'")
		end
	end)
end, {})

--luasnip
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

--ftplugin
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

--qflist
create_command("Clearqflist", function()
	vim.fn.setqflist({})
	vim.cmd("cclose")
end, {})

create_command("Echoqflist", function()
	local result = vim.api.nvim_exec("echo len(getqflist())", true)
	print(result)
end, {})

vim.cmd([[
	cnoreabbrev clearqflist Clearqflist
]])

--history delete
create_command("CmdlineHistoryDel", function()
	vim.fn.histdel(":")
end, {})

-- git --
--Glog
create_command("Glog", function()
	vim.cmd([[tabnew | term git lg1]])
	vim.cmd("set ft=fugitive")
	-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
end, {})

-- smart commit push
create_command("Gcommit", function()
	local message = vim.fn.input("commit message: ")
	if message ~= "" then
		shell_cmd({ "git", "commit", "-am", message }, function()
			print("commited")
		end, function()
			print("error while commit")
		end)

		local remote = vim.api.nvim_exec("G remote -v", true)
		if remote ~= "" then
			local loc = remote:match("https://[^/]+/([%w-]+/[%w-]+)%.?git?%s+%(%w+%)")
			local ans = vim.fn.confirm('push to "' .. loc .. '"', "&Yes\n&No")
			if ans == 1 then
				shell_cmd({ "git", "push" }, function()
					print("pushed to " .. loc)
				end, function()
					print("error during push")
				end)
			end
		end
	end
end, {})

-- GBrowse without plugin
create_command("Gbrowse", function()
	local g_remote = vim.api.nvim_exec("G remote -v", true)
	local url = g_remote:match("https://[^%s]+%.git%s+%(push%)"):gsub("%.git%s+%(push%)", "")
	local branch_name = vim.api.nvim_exec("!git branch -v", true):match("%* (%S+)")
	local g_root = vim.api.nvim_exec("!git rev-parse --show-toplevel", true)
	local git_root = g_root:match("([/][^\r\n]+)"):gsub("\r", "")

	local file_path = vim.fn.expand("%:p")
	local relative_path = file_path:sub(#git_root + 2)

	local repo_url = url .. "/blob/" .. branch_name .. "/" .. relative_path

	shell_cmd({ "open", repo_url }, function()
		print("opening " .. vim.fn.expand("%:p:t"))
	end, function()
		print("failed to open")
	end)
end, {})
