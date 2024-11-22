return {
	{
		"echasnovski/mini.statusline",
		version = "*",
		config = function()
			local MiniStatusline = require("mini.statusline")
			-- lsp
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
			-- branch
			local cached_branch = nil
			local function get_git_branch()
				if cached_branch then
					return cached_branch
				end
				local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
				local branch = handle:read("*a") or ""
				handle:close()
				branch = branch:gsub("%s+", "")
				cached_branch = branch ~= "" and branch or nil
				return cached_branch
			end
			vim.api.nvim_create_autocmd("DirChanged", {
				callback = function()
					cached_branch = nil
				end,
			})
			MiniStatusline.setup({
				use_icons = true,
				content = {
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 40 })
						local body = "MiniStatuslineFilename"
						local diagnostics = MiniStatusline.section_diagnostics({
							trunc_width = 75,
							icon = "",
							signs = { ERROR = "E", WARN = "W", INFO = "I", HINT = "*" },
						})
						local pathname = vim.bo.buftype == "terminal" and "%t"
							or "%#MiniStatuslineFilename#"
								.. vim.fn.expand("%:~")
								.. (vim.bo.modified and " [+]" or "")

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { "[" .. mode:sub(1, 3):upper() .. "]" } },
							{ hl = body, strings = { get_git_branch() } },

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
