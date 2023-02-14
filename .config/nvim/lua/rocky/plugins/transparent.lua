local autopairs_setup, transparent = pcall(require, "transparent")
if not autopairs_setup then
	return
end
transparent.setup({
  enable = true, -- boolean: enable transparent
})
