local M = {}

local abolish_file = vim.fn.stdpath("config") .. "/abolish.txt"

-- Function to load mappings from the file
function M.load_abolish()
    local abolish = {}
    local file = io.open(abolish_file, "r")
    if file then
        for line in file:lines() do
            local trimmed_line = vim.trim(line)
            if trimmed_line:match("%S") then -- Ignore empty or whitespace-only lines
                table.insert(abolish, trimmed_line)
            end
        end
        file:close()
    else
        vim.notify("Abolish file not found: " .. abolish_file, vim.log.levels.ERROR)
    end
    return abolish
end

-- Function to add a mapping dynamically
function M.add_mapping(pattern, replacement)
    local mapping = vim.trim(pattern) .. " " .. vim.trim(replacement)

    -- Append to the file
    local file = io.open(abolish_file, "a")
    if file then
        file:write(mapping .. "\n")
        file:close()
    else
        vim.notify("Failed to open abolish file for writing", vim.log.levels.ERROR)
        return
    end

    -- Reload mappings
    M.reload_mappings()
end

-- Function to reload mappings
function M.reload_mappings()
    local mappings = M.load_abolish()
    for _, mapping in ipairs(mappings) do
        -- Add your logic to apply the mapping, e.g., vim.cmd("Abolish " .. mapping)
        vim.cmd("Abolish " .. mapping)
    end
end

return M
