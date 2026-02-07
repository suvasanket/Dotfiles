Autocmd = vim.api.nvim_create_autocmd
Augroup = vim.api.nvim_create_augroup

function Map(mode, lhs, rhs, opts)
    local options = { silent = true }
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

function GetProjectRoot(markers, path_or_bufnr)
    local patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod", "pom.xml", "build.gradle" }

    if markers then
        return vim.fs.root(path_or_bufnr or 0, markers) or nil
    end

    local ok, root = pcall(vim.fs.root, path_or_bufnr or 0, patterns)
    if not ok then
        return nil
    end

    if root then
        return root
    else
        local workspace = vim.lsp.buf.list_workspace_folders()
        workspace = workspace[#workspace]
        if workspace == vim.fn.expand("~"):gsub("/$", "") then
            return nil
        end
        return workspace or nil
    end
end
