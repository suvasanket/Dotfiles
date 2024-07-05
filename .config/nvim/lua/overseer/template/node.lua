return {
	name = "node",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "node", file },
			components = {
				{ "open_output", direction = "dock", on_start = "if_no_on_output_quickfix" },
				"on_result_diagnostics_quickfix",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "javascript" },
	},
}
