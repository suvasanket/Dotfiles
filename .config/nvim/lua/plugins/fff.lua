return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	opts = { keymaps = { close = "<C-c>" } },
	keys = {
		{
			"<C-f>",
			function()
				local fp = vim.bo.ft == "oil" and require("oil").get_current_dir() or GetProjectRoot()
				require("fff").find_files_in_dir(fp)
			end,
			desc = "FFFind files",
		},
	},
}
