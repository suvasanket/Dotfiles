local M = {}

function M.map(mode, lhs, rhs, opts)
	local options = { silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function M.ftmap(ft, mode, map, cmd)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { ft },
		callback = function(event)
			vim.keymap.set(mode, map, cmd, { buffer = event.buf })
		end,
	})
end

function M.root()
	local patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod" }
	return vim.fs.root(0, patterns) or nil
end

--- setup plugin
---@param name string plugin name
---@param event string|stringlib event
---@param tbl table config table
function M.set(name, event, tbl)
	vim.api.nvim_create_autocmd(event, {
		callback = function()
			if not tbl then
				tbl = {}
			end
			require(name).setup(tbl)
		end,
	})
end

function M.cmdcr(cmd)
	return "<Cmd>" .. cmd .. "<CR>"
end

return M
