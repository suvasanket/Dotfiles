return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		-- icons --
		require("mini.icons").setup()

		-- bracketed --
		require("mini.bracketed").setup()

		-- move --
		require("mini.move").setup({
			mappings = {
				left = "<C-h>",
				right = "<C-l>",
				down = "<C-j>",
				up = "<C-k>",
				line_left = "<C-h>",
				line_right = "<C-l>",
				line_down = "<C-j>",
				line_up = "<C-k>",
			},
		})

		-- cmdline --
		require("mini.cmdline").setup({ autocomplete = { enable = false } })

		-- ai --
		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = {
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
				a = ai.gen_spec.argument(),
			},
		})

		-- diff --
		require("mini.diff").setup({ view = { style = "sign" } })
		vim.keymap.set("n", "<leader>gd", "<cmd>lua MiniDiff.toggle_overlay()<cr>")

		-- surround --
		require("mini.surround").setup()

		-- hipatterns --
		require("mini.hipatterns").setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()WIP()%f[%W]", group = "MiniHipatternsNote" },

				hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
			},
		})

		-- trailspace --
		require("mini.trailspace").setup({
			only_in_normal_buffers = true,
		})
		vim.keymap.set("n", "<leader>bt", "<cmd>lua MiniTrailspace.trim()<cr>")

		-- splitjoin --
		require("mini.splitjoin").setup({ mappings = { toggle = "<M-j>" } })

        -- statusline --
        require("mini.statusline").setup()
	end,
}
