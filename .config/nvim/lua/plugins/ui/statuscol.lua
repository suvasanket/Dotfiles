return {
	"luukvbaal/statuscol.nvim",
	event = { "BufEnter" },
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
			  { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
			  { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
			  { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
			  { sign = { name = { ".*" }, namespace = { "gitsigns" }, colwidth = 2 }, click = "v:lua.ScSa" },
			}
		})
	end,
}