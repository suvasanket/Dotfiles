--{{{
---@diagnostic disable: lowercase-global
-- vim: foldmethod=marker
-- vim: foldlevel=0
local create_command = vim.api.nvim_create_user_command
local ex = vim.fn.expand
pwd = vim.fn.expand("%:p:h")
file = vim.fn.expand("%:t")
filewe = vim.fn.expand("%:t:r")

function term(cmd)
	local ter = table.concat({ "split | resize 15 | term ", cmd })
	vim.cmd(ter)
end

function sh(cmd)
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
function javac()
	local cwd = ex("%:p:h")
	local file = ex("%:t")
	local filewe = ex("%:t:r")
	local shit = "cd " .. cwd .. " && javac " .. file .. " && java " .. filewe .. " && rm " .. filewe .. ".class"
	term(shit)
end

function clang()
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
			vim.cmd("echo'👍'")
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
	print("qflist cleaned")
end, {})

create_command("Echoqflist", function()
	local result = vim.api.nvim_exec("echo len(getqflist())", true)
	print(result)
end, {})

vim.cmd([[
	cnoreabbrev clearqflist Clearqflist
]])

create_command("MakeC", function()
	vim.cmd("Trouble close")
	vim.cmd("w")
	vim.cmd("Make%")
end, {})

--history delete
create_command("CmdlineHistoryDel", function()
	vim.fn.histdel(":")
end, {})

-- git --

-- add remote
create_command("Gremoteadd", function()
	local user_input = vim.fn.input("remote url:")
	if user_input ~= "" then
		vim.cmd("G remote add origin " .. user_input)
	else
		print("no input")
	end
end, {})

-- Ensure plenary.nvim is installed
require('plenary')

-- Import Plenary's async utilities
local async = require('plenary.async')

-- Define the command using Plenary's async utilities
vim.api.nvim_create_user_command("Gcommitpush", async.void(function()
	-- Function to run a command and capture its output
	local function run_cmd(cmd)
		local result = {}
		local handle = io.popen(cmd)
		for line in handle:lines() do
			table.insert(result, line)
		end
		handle:close()
		return table.concat(result, "\n")
	end

	-- Check if a Git remote is set
	local result = run_cmd("git remote -v")
	local message = vim.fn.input("commit message: ")

	if message ~= "" then
		-- Perform Git commit
		run_cmd("git commit -am \"" .. message .. "\"")

		-- Check if Git remote exists and push
		if result ~= "" then
			run_cmd("git push")
		end
	else
		print("abort")
	end
end), {})
