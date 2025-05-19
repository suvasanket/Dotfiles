local function relative_path(full_path, short_path)
	if not full_path or not short_path then
		return "[No Name]"
	end
	local rel_path = full_path:match("^" .. vim.pesc(short_path) .. "(.*)$")
	return rel_path and rel_path:gsub("^/", "") or full_path
end

return {
	"echasnovski/mini.nvim",
	event = "BufEnter",
	config = function()
		-- icons --
		require("mini.icons").setup()

		-- ai --
		local ai = require("mini.ai")
		ai.setup({
			n_lines = 500,
			custom_textobjects = {
				o = ai.gen_spec.treesitter({ -- code block
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
				d = { "%f[%d]%d+" }, -- digits
				e = { -- Word with case
					{
						"%u[%l%d]+%f[^%l%d]",
						"%f[%S][%l%d]+%f[^%l%d]",
						"%f[%P][%l%d]+%f[^%l%d]",
						"^[%l%d]+%f[^%l%d]",
					},
					"^().*()$",
				},
				u = ai.gen_spec.function_call(), -- u for "Usage"
				U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
			},
		})

		-- diff --
		require("mini.diff").setup({
			view = {
				-- style = vim.go.number and "sign" or "number",
				style = "sign",
				signs = { add = "│", change = "│", delete = "│" },
				priority = 199,
			},
			mappings = {
				apply = "gh",
				reset = "g0",
				textobject = "gh",
				goto_first = "[H",
				goto_prev = "[h",
				goto_next = "]h",
				goto_last = "]H",
			},
		})
		Map("n", "<leader>gd", ":lua MiniDiff.toggle_overlay()<cr>")

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
		local hipatterns = require("mini.hipatterns")
		require("mini.hipatterns").setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()WIP()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- trailspace --
		require("mini.trailspace").setup({
			only_in_normal_buffers = true,
		})
		Map("n", "<leader>bt", "<cmd>lua MiniTrailspace.trim()<cr>")

		-- statusline --
		local MiniStatusline = require("mini.statusline")
		-- lsp
		local lsp = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local icon = require("mini.icons").get("file", vim.fn.expand("%"))

			local clients = vim.lsp.get_clients({ bufnr = bufnr })
			if next(clients) == nil then
				return icon .. " no_server"
			end

			local c = {}
			for _, client in pairs(clients) do
				if client.name ~= "null-ls" then
					table.insert(c, client.name)
				end
			end
			return icon .. " " .. table.concat(c, ",")
		end
		-- branch
		local function get_git_branch()
			local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
			local branch = handle:read("*a") or ""
			handle:close()
			branch = branch:gsub("%s+", "")
			return branch ~= "" and branch or nil
		end
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

					local filename = function()
						if vim.bo.filetype == "oil" then
							return vim.fn.expand("%"):sub(7):gsub(os.getenv("HOME"), "~")
						elseif vim.fn.expand("%"):find("oz.*://.*") then
							return vim.fn.expand("%")
						end
						local fname = relative_path(vim.fn.expand("%:p"), GetProjectRoot() or vim.fn.getcwd())
						local mod = vim.bo.modified and "[+]" or ""
						return fname .. " " .. mod
					end

					local filetype = function()
						local ft = vim.bo.filetype
						if ft ~= "" then
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
						{ hl = body, strings = { filename() .. git_branch() } },
						"%=", -- End left alignment

						{ hl = body, strings = { diagnostics } },
						{ hl = body, strings = { lsp() .. " " .. filetype() .. " [%3l:%-2v]" } },
						-- { hl = body, strings = { "[%3l:%L|%-2v]" } },
					})
				end,
				inactive = function()
					local filename = vim.fn.expand("%") .. (vim.bo.modified and " [+]" or "")
					local body = "MiniStatuslineFilename"

					return MiniStatusline.combine_groups({
						{ hl = body, strings = { filename } },
						"%=", -- End left alignment
						{ hl = body, strings = { "%3l:%-2v" } },
					})
				end,
			},
			set_vim_settings = true, -- Make sure statusline is always shown
		})
	end,
}
