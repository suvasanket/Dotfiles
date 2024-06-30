function ftmap(tbl)
	ft = vim.fn.expand("%:t:r") or tbl.filetype
	keys = tbl[1] or tbl.keys
	cmd = tbl[2] or tbl.cmd
	mode = tbl[3] or tbl.mode
	desc = tbl[4] or tbl.desc

	if mode == nil then
		mode = "n"
	end
	if desc == nil then
		desc = cmd
	end
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ft,
		callback = function(event)
			vim.keymap.set(mode, keys, cmd, { buffer = event.buf, desc = desc })
		end,
	})
end
