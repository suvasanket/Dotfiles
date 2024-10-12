return {
	{
		"echasnovski/mini.statusline",
		version = "*",
		config = function()
			local MiniStatusline = require("mini.statusline")
			local lsp = function()
				local bufnr = vim.api.nvim_get_current_buf()

				local clients = vim.lsp.buf_get_clients(bufnr)
				if next(clients) == nil then
					return ""
				end

				local c = {}
				for _, client in pairs(clients) do
					if client.name ~= "null-ls" then
						table.insert(c, client.name)
					end
				end
				return "󰅠 " .. table.concat(c, ",") .. " "
			end
			require("mini.statusline").setup({
				content = {
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 40 })
						local body = "MiniStatuslineFilename"
						local git = MiniStatusline.section_git({ trunc_width = 75, icon = "" })
						local diagnostics = MiniStatusline.section_diagnostics({
							trunc_width = 75,
							icon = "",
							signs = { ERROR = "!", WARN = "?", INFO = "@", HINT = "*" },
						})

						local pathname = vim.bo.buftype == "terminal" and "%t"
							or "%#MiniStatuslineFilename#"
								.. vim.fn.expand("%:~")
								.. (vim.bo.modified and " [+]" or "")

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { "[" .. mode:sub(1, 3):upper() .. "]" } },
							{ hl = body, strings = { git } },

							"%<", -- Mark general truncate point
							"%=", -- End left alignment
							{ hl = body, strings = { pathname } },
							"%=", -- End left alignment

							{ hl = body, strings = { diagnostics } },
							{ hl = body, strings = { lsp() } },
							{ hl = body, strings = { "[%-2l:%-2v]" } },
						})
					end,
				},
				set_vim_settings = true, -- Make sure statusline is always shown
			})
		end,
	},
}
