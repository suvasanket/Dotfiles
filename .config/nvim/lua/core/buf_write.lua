--{{{ func
-- vim: foldmethod=marker
-- vim: foldlevel=0
augroup("hotreload", { clear = true })
local file_actions = {}

local function post_act(filename, action)
	file_actions[filename] = action
	local patterns = vim.tbl_keys(file_actions)

	autocmd("BufWritePost", {
		group = "hotreload",
		pattern = patterns,
		callback = function()
			local filename = vim.fn.expand("%:t")
			local action = file_actions[filename]
			if action then
				action()
			end
		end,
	})
end
--}}}

post_act("*/ftplugin/*.lua", function()
	vim.cmd("silent source%")
end)

post_act("*/core/*.lua", function()
	vim.cmd("silent source%")
end)

post_act("tmux.conf", function()
	vim.cmd("silent !tmux source /Users/suvasanketrout/.config/tmux/tmux.conf")
end)

post_act("aerospace.toml", function()
	vim.cmd("silent !aerospace reload-config")
end)

post_act("abolish.lua", function()
	vim.fn.timer_start(2000, function()
		vim.cmd("silent Lazy reload vim-abolish")
	end)
end)

post_act("statusline.lua", function()
	vim.fn.timer_start(2000, function()
		vim.cmd("silent Lazy reload lualine.nvim")
	end)
end)
