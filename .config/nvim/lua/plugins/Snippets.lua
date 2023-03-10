return {
	--LuaSnip
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		event = "InsertEnter",
		config = function()
			local ls = require("luasnip")
			-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
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
							virt_text = { { "●", "GruvboxOrange" } },
						},
					},
					-- [types.insertNode] = {
					-- 	active = {
					-- 		virt_text = { { "●", "GruvboxBlue" } },
					-- 	},
					-- },
				},
			}) --}}}
			-- Key Mapping --{{{
			vim.keymap.set({ "i", "s" }, "<C-s>", "<Esc>:w<cr>")
			vim.keymap.set({ "i", "s" }, "<C-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

			vim.keymap.set({ "i", "s" }, "<c-]>", function()
				if ls.expand_or_jumpable() then
					ls.expand()
				end
			end, { silent = true })

			-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
			-- 	if ls.expand_or_jumpable(1) then
			-- 		ls.expand_or_jump(1)
			-- 	end
			-- end, { silent = true })
			-- vim.keymap.set({ "i", "s" }, "<C-h>", function()
			-- 	if ls.jumpable(-1) then
			-- 		ls.jump(-1)
			-- 	end
			-- end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-y>", "<Esc>o", { silent = true })

			-- vim.keymap.set({ "i", "s" }, "<a-k>", function()
			-- 	if ls.jumpable(1) then
			-- 		ls.jump(1)
			-- 	end
			-- end, { silent = true })
			-- vim.keymap.set({ "i", "s" }, "<a-j>", function()
			-- 	if ls.jumpable(-1) then
			-- 		ls.jump(-1)
			-- 	end
			-- end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<tab>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				else
					-- print current time
					local t = os.date("*t")
					local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
					print(time)
				end
			end)
			vim.keymap.set({ "i", "s" }, "<s-tab>", function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end) --}}}

			-- More Settings --

			vim.cmd(
				[[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]]
			)
		end,
	},
	--snippets
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },

	--friendly-snippets
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
