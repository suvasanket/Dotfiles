Autocmd = vim.api.nvim_create_autocmd
Augroup = vim.api.nvim_create_augroup

function Map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function CMD(command)
	return table.concat({ "<Cmd>", command, "<CR>" })
end

-- async cmd
function ShellCmd(cmd, on_success, on_error)
	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_exit = function(_, code)
			if code == 0 then
				if on_success then
					on_success()
				end
			else
				if on_error then
					on_error()
				end
			end
		end,
	})
end

function BufMap(ft, mode, map, cmd)
	Autocmd("FileType", {
		pattern = { ft },
		callback = function(event)
			vim.keymap.set(mode, map, cmd, { buffer = event.buf })
		end,
	})
end

function Telescope(cmd)
	return table.concat({
		"<cmd>Telescope ",
		cmd,
		" prompt_title=false preview_title=false result_title=false<cr>",
	})
end

function GetProjectRoot()
	local workspace = vim.lsp.buf.list_workspace_folders()
    local firstworkspace = workspace[1]
	if firstworkspace then
        if firstworkspace == vim.fn.expand("~"):gsub("/$", "") then
            return vim.fn.getcwd()
        end
		return firstworkspace
	end
    return vim.fs.root(0, ".git") or vim.fn.getcwd()
end

function Notify(content, level, title)
	if not title then
		title = "Notification"
	end
	vim.notify(content, level, { title = title })
end

Augroup("hotreload", { clear = true })
function BufWritePostFunc(pattern, func)
	Autocmd("BufWritePost", {
		group = "hotreload",
		pattern = pattern,
		callback = func,
	})
end

function UserInput(msg, def)
	local ok, input = pcall(vim.fn.input, msg, def or "")
	if ok then
		return input
	end
end
function TableContainsValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
