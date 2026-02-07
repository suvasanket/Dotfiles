return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		-- icons --
		require("mini.icons").setup()

		-- cmdline --
		require("mini.cmdline").setup({ autocomplete = { enable = false } })

		-- extra --
		local extra = require("mini.extra")
		extra.setup()
		vim.keymap.set("n", "<leader>cd", extra.pickers.diagnostic)

		-- pick --
		local pick = require("mini.pick")
		pick.setup({
			mappings = {
				delete_char = "<C-h>",
				refine = "<C-enter>",
				mark_all = "<S-TAB>",
			},
		})
		vim.ui.select = pick.ui_select
		vim.keymap.set("n", "<C-g>", ":Pick oldfiles<cr>")
		vim.keymap.set("n", "<leader>sh", pick.builtin.help)
		vim.keymap.set("n", "<leader>'", pick.builtin.grep_live)

		-- notify --
		local notify = require("mini.notify")
		notify.setup({ lsp_progress = { enable = false } })
		local mini_notify = notify.make_notify()
		vim.notify = function(msg, level, opts)
			opts = opts or {}
			if opts.title ~= nil then
				msg = string.format("[[%s]]: %s", opts.title, msg)
			end
			mini_notify(msg, level)
		end

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
		require("mini.surround").setup({
			mappings = {
				add = "ys",
				delete = "ds",
				replace = "cs",
				find = "",
				find_left = "",
				highlight = "",
				update_n_lines = "",
			},
		})
		vim.keymap.del("x", "ys")
		vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
		vim.keymap.set("n", "yss", "ys_", { remap = true })

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

		-- statusline --
		require("mini.statusline").setup()

		-- splitjoin --
		require("mini.splitjoin").setup({ mappings = { toggle = "<C-j>" } })
	end,
}
