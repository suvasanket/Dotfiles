return {
	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.1",
		keys = {
			{ "<leader>a", "<cmd>Telescope oldfiles<cr>", desc = "RecentFile" },
			{ "<leader>ch", "<cmd>Telescope command_history<cr>", desc = "CommandHist" },
			{ "<leader>ht", "<cmd>Telescope help_tags<cr>", desc = "HelpTags" },
		},

		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
			},
		},
	},

	--fzf
	{
		"junegunn/fzf",
		keys = {
			{ "<C-f>", "<cmd>FZF ~<cr>", desc = "fzf" },
		},
		config = function()
			vim.cmd([[
        let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git -o -name Library -o -name zsh-autocomplete -o -name .vim -o -name .oh-my-zsh -o -name .vscode -o -name .local -o -name .cargo -o -name .rustup -o -name .cache -o -name .m2 -o -name .fzf -o -name .git -o -name .gitignore \) -prune -o -print'
        let g:fzf_layout = { 'down': '30%' }
            autocmd! FileType fzf
            autocmd  FileType fzf
              \| autocmd BufLeave <buffer>
            command! FZFMru call fzf#run({
            \  'source':  v:oldfiles,
            \  'sink':    'e',
            \  'options': '-m -x +s',
            \  'down':    '40%'})

            let g:fzf_action = {
              \ 'ctrl-t': 'tab split',
              \ 'ctrl-x': 'split',
              \ 'ctrl-v': 'vsplit' }
        ]])
		end,
	},
}
