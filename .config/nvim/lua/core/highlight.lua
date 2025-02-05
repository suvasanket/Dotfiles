local hi = function(name, val, id)
	local defaultid = 0
	if id then
		defaultid = id
	end
	vim.api.nvim_set_hl(defaultid, name, val)
end
local batchHl = function(hl_group, id)
	local highlights = vim.fn.getcompletion(hl_group, "highlight") -- Get all highlight groups starting with "Normal"
	for _, name in ipairs(highlights) do
		vim.api.nvim_set_hl(0, name, id) -- Set the background to NONE
	end
end

Autocmd("VimEnter", {
	pattern = "*",
	callback = function()
        hi("hlyank", { bg = "#FF9B50" })

        hi("SnacksNotifierBorderInfo", { link = "@string" })
        hi("SnacksNotifierTitleInfo", { link = "@string" })

        hi("MiniStatuslineModeNormal", { bold = true })

		batchHl("DiagnosticError", { bg = "NONE", fg = "#eb5f61" })
		batchHl("DiagnosticWarn", { bg = "NONE", fg = "#ee7f25" })
		batchHl("DiagnosticInfo", { bg = "NONE" })
		batchHl("DiagnosticHint", { bg = "NONE" })
	end,
})

--highlight yank
Augroup("yank", { clear = true })
Autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "hlyank", timeout = 70 })
	end,
	group = "yank",
})
