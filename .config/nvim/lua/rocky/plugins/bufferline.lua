local buffer = require("bufferline")
buffer.setup({
	options = {
		separator_style = "thick",
		diagnostics = "nvim_lsp",
		show_close_icon = false,
		buffer_close_icon = "*",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
		always_show_bufferline = false,
	},
})

vim.cmd([[
  nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
  nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
  nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
  nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
  nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
  nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
  nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
  nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
  nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
  nnoremap <silent><leader>$ <Cmd>BufferLineGoToBuffer -1<CR>
]])
