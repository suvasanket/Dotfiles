return {
	"luukvbaal/statuscol.nvim",
	event = { "BufReadPre", "BufNewFile" },
	enabled = false,
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			ft_ignore = { "NeogitStatus", "oil", "starter", "Trouble", "undotree", "Outline" },
			relculright = true,
			segments = {
				{
					sign = {
						name = { "Dap*" },
						auto = true,
					},
					click = "v:lua.ScSa",
					condition = {
						function(args)
							return vim.api.nvim_get_current_win() == args.win
						end,
					},
				},
				{
					sign = {
						name = { "Diagnostic" },
						auto = true,
					},
					click = "v:lua.ScSa",
					condition = {
						function(args)
							return vim.api.nvim_get_current_win() == args.win
						end,
					},
				},
				{
					text = { builtin.lnumfunc, " " },
					click = "v:lua.ScLa",
					condition = {
						function(args)
							return vim.api.nvim_get_current_win() == args.win
						end,
					},
				},
				{
					sign = {
						namespace = { "gitsign*" },
					},
					click = "v:lua.ScSa",
					condition = {
						function(args)
							return vim.api.nvim_get_current_win() == args.win
						end,
					},
				},
			},
		})
	end,
}
