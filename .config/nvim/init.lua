vim.g.mapleader = " "

local start = vim.uv.hrtime()

require("plugins")
vim.schedule(function()
	require("other")
	require("keymaps")
end)

vim.defer_fn(function()
    local ms = math.floor((vim.uv.hrtime() - start) / 1e6)
    vim.keymap.set("n", "<leader>0", function()
        print(string.format("Startup time: %s", ms))
    end)
end, 0)
