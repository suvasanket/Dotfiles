Autocmd = vim.api.nvim_create_autocmd
Augroup = vim.api.nvim_create_augroup

function Map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function CMD(command)
	return table.concat({ "<Cmd>", command, "<CR>" })
end

-- async cmd
function ShellCmd(cmd, on_success, on_error)
	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_exit = function(_, code)
			if code == 0 then
				if on_success then
					on_success()
				end
			else
				if on_error then
					on_error()
				end
			end
		end,
	})
end

function BufMap(ft, mode, map, cmd)
	Autocmd("FileType", {
		pattern = { ft },
		callback = function(event)
			vim.keymap.set(mode, map, cmd, { buffer = event.buf })
		end,
	})
end

function Telescope(cmd)
	return table.concat({ "<cmd>Telescope ", cmd, " prompt_title=false preview_title=false result_title=false<cr>" })
end

function GetProjectRoot()
	local workspace = vim.lsp.buf.list_workspace_folders()
	local wd = ""
	local v = vim

	if workspace[1] ~= nil then
		wd = workspace[1]
	else
		local git_root = v.fn.systemlist("git rev-parse --show-toplevel")
		if v.v.shell_error == 0 then
			wd = git_root[1]
		else
			wd = v.fn.getcwd()
		end
	end
	return wd
end

function Notify(content, level, title)
	require("fidget").notify(title .. ":", level, {
		group = title,
		annote = content .. "",
	})
end
