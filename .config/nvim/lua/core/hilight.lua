local hi = function(name, val, id)
	local defaultid = 0
	if id then
		defaultid = id
	end
	vim.api.nvim_set_hl(defaultid, name, val)
end

autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		hi("Folded", { fg = "#7D7C7C" })
		hi("Search", { link = "IncSearch" })

		hi("IlluminatedWordText", { link = "Visual" })
		hi("IlluminatedWordRead", { link = "Visual" })
		hi("IlluminatedWordWrite", { link = "Visual" })

		hi("TreesitterContext", { link = "CursorLine" })

		hi("TroubleNormal", { link = "Normal" })
		hi("TroubleNormalNC", { link = "Normal" })

		hi("hlyank", { bg = "#FF9B50" })
		hi("NormalFloat", { link = "Normal" })
		hi("FloatBorder", { bg = NONE })

		hi("TelescopeBorder", {  fg = "#272829", bg = "#222222" })
		hi("TelescopeNormal", {  bg = "#222222" })
		hi("TelescopePromptBorder", { link = "TelescopeBorder" })
		hi("TelescopeResultsBorder", { link = "TelescopeBorder" })
		hi("TelescopePreviewBorder", { link = "TelescopeBorder" })

		hi("CmpItemAbbrMatchFuzzyDefault", { fg = "#F2613F" })
		hi("PmenuSel", { bg = "#282C34", fg = "NONE" })
		hi("Pmenu", { fg = "#C5CDD9", bg = "#22252A" })
		hi("CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE" })
		hi("CmpItemAbbrMatch", { fg = "#A5F1E9", bg = "NONE", bold = true })
		hi("mpItemAbbrMatchFuzzy", { fg = "#A5F1E9", bg = "NONE", bold = true })
		hi("Pmenu", { bg = "#222222" })

		--fleet
		hi("TabLineSel", { fg = "#B4B4B3" })
		hi("@string", { fg = "#80AF81" })
		hi("MiniIndentscopeSymbol", { fg = "#45474B" })
		hi("FloatBorder", { fg = "#434242" })
		hi("DiagnosticSignError", { fg = "#eb5f61" })
		hi("DiagnosticSignWarn", { fg = "#ee7f25" })
		hi("ObsidianRefText", { fg = "#DBB5B5" })
		hi("RenderMarkdownCode", { link = "CursorLine" })
		hi("WinSeparator", { link = "TabLineSel" })
		-- hi("WhichKeyNormal", { link = "CursorLine" })
	end,
})

--highlight yank
augroup("yank", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "hlyank", timeout = 100 })
	end,
	group = "yank",
})
