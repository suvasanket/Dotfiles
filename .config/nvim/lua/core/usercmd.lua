---@diagnostic disable: lowercase-global
local create_command = vim.api.nvim_create_user_command
local ex = vim.fn.expand
cwd = vim.fn.expand("%:p:h")
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
create_command("Run", function()
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
