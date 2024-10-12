return {
	--LuaSnip
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require("luasnip") --{{{
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
			require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

			-- Virtual Text{{{
			local types = require("luasnip.util.types")
			ls.config.set_config({
				history = true, --keep around last snippet local to jump back
				updateevents = "TextChanged,TextChangedI", --update changes as you type
				enable_autosnippets = true,
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "", "@method" } },
						},
					},
				},
			}) --}}}

			-- Key Mapping --{{{
			vim.keymap.set({ "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')
			vim.keymap.set({ "i", "s" }, "<C-CR>", function ()
				ls.expand()
			end, { silent = true })
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
			vim.keymap.set({ "i", "s" }, "<C-n>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
