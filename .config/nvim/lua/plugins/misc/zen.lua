return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	dependencies = { "folke/twilight.nvim" },
	opts = {
		window = {
			backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
			width = 120, -- width of the Zen window
			height = 1, -- height of the Zen window
			options = {
				signcolumn = "no", -- disable signcolumn
				number = false, -- disable number column
				relativenumber = false, -- disable relative numbers
				-- cursorline = false, -- disable cursorline
				-- cursorcolumn = false, -- disable cursor column
				-- foldcolumn = "0", -- disable fold column
				-- list = false, -- disable whitespace characters
			},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = true, -- disables the ruler text in the cmd line area
				showcmd = false, -- disables the command in the last line of the screen
				laststatus = 0, -- turn off the statusline in zen mode
			},
			twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
			gitsigns = { enabled = false }, -- disables git signs
			tmux = { enabled = false }, -- disables the tmux statusline
			kitty = {
				enabled = true,
				font = "+2", -- font size increment
			},
		},
	},
}
