local function relative_path(fullpath, shortpath)
	if fullpath:find(shortpath) then
		return fullpath:gsub(shortpath, ""):sub(2)
	end
	return fullpath
end

return {
	{
		"echasnovski/mini.statusline",
		event = { "VeryLazy", "BufEnter" },
		config = function()
			local MiniStatusline = require("mini.statusline")
			-- lsp
			local lsp = function()
				local bufnr = vim.api.nvim_get_current_buf()

				local clients = vim.lsp.buf_get_clients(bufnr)
				if next(clients) == nil then
					return "⨯ no server"
				end

				local c = {}
				for _, client in pairs(clients) do
					if client.name ~= "null-ls" then
						table.insert(c, client.name)
					end
				end
				return " " .. table.concat(c, ",")
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
						local pathname = vim.bo.buftype == "terminal" and "terminal" --"%t"
							or "%#MiniStatuslineFilename#"
								.. vim.fn.expand("%")
								.. (vim.bo.modified and " [+]" or "")

						local filename = vim.bo.filetype == "oil" and vim.fn.expand("%"):sub(7)
							or relative_path(vim.fn.expand("%:p"), GetProjectRoot())
								.. (vim.bo.modified and " [+]" or "")

						local filetype = function()
							local ft = vim.bo.filetype
							if ft then
								return "(" .. ft .. ")"
							else
								return ""
							end
						end
						local git_branch = function()
							local branch = get_git_branch()
							if branch then
								return "(" .. branch .. ")"
							else
								return ""
							end
						end

						local location = MiniStatusline.section_location({ trunc_width = 75 })
						local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
						local first = mode
						if search ~= "" then
							first = search
						else
							first = mode:sub(1, 3):upper()
						end
						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { "[" .. first .. "]" } },

							"%<", -- Mark general truncate point
							-- "%=", -- End left alignment
							{ hl = body, strings = { filename } },
							{ hl = body, strings = { git_branch() } },
							"%=", -- End left alignment

							{ hl = body, strings = { diagnostics } },
							{ hl = body, strings = { lsp() .. " " .. filetype() } },
							{ hl = body, strings = { "[%3l:%L|%-2v]" } },
						})
					end,
				},
				set_vim_settings = true, -- Make sure statusline is always shown
			})
		end,
	},
}
