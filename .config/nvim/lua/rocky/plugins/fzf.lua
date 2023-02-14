vim.cmd([[
let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git -o -name Library -o -name zsh-autocomplete -o -name .vim -o -name .oh-my-zsh -o -name .vscode -o -name .local -o -name .cargo -o -name .rustup -o -name .cache -o -name .m2 -o -name .fzf -o -name .git -o -name .gitignore \) -prune -o -print'
let g:fzf_layout = { 'down': '30%' }
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    command! FZFMru call fzf#run({
    \  'source':  v:oldfiles,
    \  'sink':    'e',
    \  'options': '-m -x +s',
    \  'down':    '40%'})
]])

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
			},
		},
	},
})
