return {
	"tpope/vim-abolish",
	cmd = { "Abolish", "S" },
	config = function()
		local abolish = require("core.abolish")
		abolish.reload_mappings()
	end,
}
