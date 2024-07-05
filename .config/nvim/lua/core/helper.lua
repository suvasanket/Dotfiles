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

function bufmap(ft, mode, map, cmd)
	autocmd("FileType", {
		pattern = { ft },
		callback = function(event)
			vim.keymap.set(mode, map, cmd, { buffer = event.buf })
		end,
	})
end
