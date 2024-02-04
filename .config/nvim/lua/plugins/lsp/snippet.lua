return {
	--LuaSnip
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		config = function()
			local ls = require("luasnip") --{{{

			require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/" })
			require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

			vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

			-- Virtual Text{{{
			local types = require("luasnip.util.types")
			ls.config.set_config({
				history = true, --keep around last snippet local to jump back
				updateevents = "TextChanged,TextChangedI", --update changes as you type
				enable_autosnippets = true,
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "<-", "Error" } },
						},
					},
					-- [types.insertNode] = {
					-- 	active = {
					-- 		virt_text = { { "<-" } },
					-- 	},
					-- },
				},
			}) --}}}

			-- Key Mapping --{{{

			vim.keymap.set({ "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

			vim.keymap.set({ "i", "s" }, "<S-CR>", "<C-c>o", { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-f>", function()
				if ls.jumpable(1) then
					ls.jump(1)
				end
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-b>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<a-p>", function()
				if ls.expand_or_jumpable() then
					ls.expand()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<a-n>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				else
					-- print current time
					local t = os.date("*t")
					local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
					print(time)
				end
			end)
			vim.keymap.set({ "i", "s" }, "<a-p>", function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end) --}}}
		end,
	},

	--scissors
	{
		"chrisgrieser/nvim-scissors",
		dependencies = "nvim-telescope/telescope.nvim", -- optional
		keys = {
			{
				"<leader><cr>",
				function()
					require("scissors").addNewSnippet()
				end,
				mode = { "n", "x" },
			},
			{
				"<leader><leader><cr>",
				function()
					require("scissors").editSnippet()
				end,
			},
		},
		opts = {
			editSnippetPopup = {
				keymaps = {
					deleteSnippet = "<C-BS>",
					openInFile = "<C-o>",
					insertNextToken = "<C-t>", -- insert & normal mode
					jumpBetweenBodyAndPrefix = "<C-Tab>", -- insert & normal mode
				},
			},
		},
	},
}
