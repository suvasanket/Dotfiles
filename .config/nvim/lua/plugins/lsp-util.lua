return {
	--Lspsaga
	{
		"glepnir/lspsaga.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>rn", "<cmd>Lspsaga rename<cr>" },
			{ "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "CodeAction" },
			{ "Up", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>" },
			{ "Down", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>" },
			{ "gf", "<cmd>Lspsaga lsp_finder<CR>", desc = "LspFinder" },
			{ "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
			{ "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Defination" },
			{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "PrevDiagnostics" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "NextDiagnostics" },
			{ "gk", "<cmd>Lspsaga hover_doc<CR>", desc = "Doc" },
			{ "<leader>O", "<cmd>Lspsaga outline<CR>", desc = "outline" },
		},
		config = function()
			require("lspsaga").setup({
				ui = {
					title = true,
					winblend = 20,
					border = "rounded",
					expand = "",
					collapse = "",
					preview = " ",
					code_action = "",
					diagnostic = "🐞",
					incoming = " ",
					outgoing = " ",
					hover = " ",
					kind = {},
				},
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					enable = true,
					enable_in_insert = true,
					sign = true,
					sign_priority = 40,
					virtual_text = false,
				},
			})

			--Guttersigns from lsp-config
			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
	},

	--Mason
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "Mason",
		dependencies = "williamboman/mason-lspconfig.nvim",
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_null_ls = require("mason-null-ls")
			mason.setup()

			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					"jdtls",
					"tsserver",
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"emmet_ls",
				},
				-- auto-install configured servers (with lspconfig)
				automatic_installation = true, -- not the same as ensure_installed
			})

			mason_null_ls.setup({
				-- list of formatters & linters for mason to install
				ensure_installed = {
					"prettier", -- ts/js formatter
					"stylua", -- lua formatter
					"eslint_d", -- ts/js linter
				},
				-- auto-install configured formatters & linters (with null-ls)
				automatic_installation = true,
			})
		end,
	},

	--Code-runner
	{
		"CRAG666/code_runner.nvim",
		cmd = "RunCode",
		opts = {
			mode = "term",
			close_key = "<C-c>",
			focus = true,
			startinsert = false,
			term = {
				close_key = "<ESC>",
				position = "bot",
				size = 10,
			},
			float = {
				close_key = "<ESC>",
				border = "none",
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,
				border_hl = "FloatBorder",
				float_hl = "Normal",
				blend = 0,
			},
			filetype_path = vim.fn.stdpath("data")
				.. "/site/pack/packer/start/code_runner.nvim/lua/code_runner/code_runner.json",
			filetype = {
				java = "cd $dir && javac $fileName && java $fileNameWithoutExt && rm $fileNameWithoutExt.class",
				python = "python3 -u",
				typescript = "deno run",
				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
				javascript = "cd $dir && node $fileName",
			},
		},
	},
}
