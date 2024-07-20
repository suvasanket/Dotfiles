autocmd = vim.api.nvim_create_autocmd
augroup = vim.api.nvim_create_augroup

function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function cmd(command)
	return table.concat({ "<Cmd>", command, "<CR>" })
end

-- async cmd
function async_cmd(cmd, on_success, on_error)
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

function bufmap(ft, mode, map, cmd)
	autocmd("FileType", {
		pattern = { ft },
		callback = function(event)
			vim.keymap.set(mode, map, cmd, { buffer = event.buf })
		end,
	})
end

function cmd_tele(cmd)
	return table.concat({ "<cmd>Telescope ", cmd, " prompt_title=false preview_title=false result_title=false<cr>" })
end
