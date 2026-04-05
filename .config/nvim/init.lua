local start = vim.uv.hrtime()

vim.g.mapleader = " "
vim.pack.add({ "https://github.com/suvasanket/fleet.nvim" })
vim.cmd.colorscheme("fleet")

vim.fn.timer_start(10, function()
	require("plugins")
	require("other")
	require("keymaps")
end)

vim.defer_fn(function()
	local ms = math.floor((vim.uv.hrtime() - start) / 1e6)
	vim.keymap.set("n", "<leader>0", function()
		print(string.format("Startup time: %s", ms))
	end)
end, 0)
