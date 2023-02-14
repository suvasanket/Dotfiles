vim.g.vaffle_force_delete = true
vim.g.vaffle_show_hidden_files = true
vim.api.nvim_create_autocmd("filetype", {
	pattern = "Vaffle",
	desc = "Better mappings for netrw",
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end
		bind("<C-p>", "q")
	end,
})
vim.cmd([[
  function! VaffleRenderCustomIcon(item)
    return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
  endfunction

  let g:vaffle_render_custom_icon = 'VaffleRenderCustomIcon'
]])
