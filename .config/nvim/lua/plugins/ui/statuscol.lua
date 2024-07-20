return {
	"luukvbaal/statuscol.nvim",
	event = { "BufEnter" },
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{ sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, auto = true }, click = "v:lua.ScSa" },
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
				{ sign = { name = { ".*" }, namespace = { "gitsigns" }, colwidth = 2, auto = false }, click = "v:lua.ScSa" },
			},
		})
	end,
}
