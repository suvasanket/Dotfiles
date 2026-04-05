local map = require("util").map
local cmd = require("util").cmdcr
local root = require("util").root()
local ftmap = require("util").ftmap

-- oz
vim.pack.add({ "file:///Users/suvasanketrout/Developer/oz-nvim" })
require("oz").setup({
	oz_git = {
		win_type = "e",
	},
})
map("n", "<leader>aq", cmd("TermClose"))
map("n", "<leader>aa", cmd("TermToggle"))
map("n", "<leader><cr>", cmd("Term"))
map("n", "<leader>i", cmd("G"))
map("n", "gw", ":Grep <C-r><C-w><cr>")
map("n", "g<cr>", ":Grep 'FIXME|TODO|WIP'<cr>")
map({ "n", "v" }, "<C-'>", function()
	if vim.fn.mode() == "n" then
		return ":Grep ''<left>"
	elseif vim.fn.mode() == "v" then
		return ":Grep<cr>"
	end
end, { expr = true, silent = false })

-- mark
vim.pack.add({ "file:///Users/suvasanketrout/Developer/buf_mark-nvim" })
require("buf_mark").setup({
	mappings = {
		marker_key = "m",
	},
})

-- snacks
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
})
map("n", "<leader>sh", cmd("lua require('snacks').picker('help')"), { desc = "help" })
map("n", "<C-f>", function()
	local root = root or vim.fn.getcwd()
	require("snacks").picker.smart({
		hidden = true,
		cwd = root,
		title = vim.fs.basename(root) .. "/",
		layout = { preset = "ivy", preview = false },
		supports_live = true,
	})
end)
map("n", "<leader>'", function()
	require("snacks").picker.grep({ cwd = root or vim.fn.getcwd() })
end)
map("n", "<leader>cd", function()
	require("snacks").picker.diagnostics()
end, { desc = "diagnostics" })

-- oil
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["gh"] = "<cmd>edit $HOME<CR>",
		["gj"] = "<cmd>edit ~/Developer/<CR>",
		["gl"] = "<cmd>edit $HOME/Downloads/<CR>",
		["yp"] = {
			desc = "Copy filepath",
			callback = function()
				require("oil.actions").copy_entry_path.callback()
				vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
			end,
		},
	},
	view_options = { show_hidden = true },
})
map("n", "-", cmd("Oil"))
ftmap("oil", "n", "=", function()
	if vim.fn.executable("zoxide") == 0 then
		vim.notify("zoxide not found", vim.log.levels.ERROR)
		return
	end
	local command_output = vim.fn.system("zoxide query -l")
	local paths = vim.split(command_output, "\n", { trimempty = true })
	vim.ui.select(paths, { prompt = "zoxide entry" }, function(choice)
		if choice then
			vim.cmd("edit " .. choice)
		end
	end)
end)

-- mini
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })
require("mini.basics").setup({
	mappings = {
		basic = false,
	},
	autocommands = {
		relnum_in_visual_mode = true,
	},
})
require("mini.icons").setup()
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
require("mini.ai").setup({
	custom_textobjects = { t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" } },
})
require("mini.surround").setup()
require("mini.diff").setup({ view = { style = "sign" } })
map("n", "<leader>gd", cmd("lua MiniDiff.toggle_overlay()"))
require("mini.hipatterns").setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	},
})
require("mini.trailspace").setup({ only_in_normal_buffers = true })
map("n", "<leader>bt", cmd("lua MiniTrailspace.trim()"))
require("mini.splitjoin").setup({ mappings = { toggle = "<M-j>" } })
require("mini.completion").setup()
require("mini.cmdline").setup()

-- mason
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
require("mason").setup()
vim.lsp.enable({ "lua_ls", "ts_ls", "sourcekit" })

-- formatter
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		swift = { "swift_format" },
	},
})
map("n", "<leader>f", cmd('lua require("conform").format({ async = true, lsp_format = "fallback", range = range })'))

-- fidget
vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup()
