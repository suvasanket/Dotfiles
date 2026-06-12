local map = require("util").map
local cmd = require("util").cmdcr
local root = require("util").root()
local ftmap = require("util").ftmap

-- oz
vim.pack.add({ {
	src = "file:///Users/suvasanketrout/Developer/oz-nvim",
	version = "feat",
} })
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
require("buf_mark").setup()

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
		wip = { pattern = "%f[%w]()WIP()%f[%W]", group = "MiniHipatternsHack" },
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	},
})
require("mini.trailspace").setup({ only_in_normal_buffers = true })
map("n", "<leader>bt", cmd("lua MiniTrailspace.trim()"))
require("mini.splitjoin").setup({ mappings = { toggle = "<M-j>" } })
require("mini.completion").setup()
require("mini.cmdline").setup()
require("mini.notify").setup({
	lsp_progress = { enable = false },
})
vim.notify = MiniNotify.make_notify()

-- mason
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
require("mason").setup()
vim.lsp.enable({ "lua_ls", "ts_ls" }) -- "sourcekit"

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

-- fff
vim.pack.add({ "https://github.com/dmtrKovalenko/fff.nvim" })
-- require('fff.download').download_or_build_binary()
require("fff").setup({
	keymaps = {
		close = "<C-c>",
	},
})

vim.keymap.set("n", "<C-f>", function()
	require("fff").find_files_in_dir(root)
end)
vim.keymap.set("n", "<C-'>", function()
	require("fff").live_grep()
	require('fff').change_indexing_directory(root)
end)
