return {
	"mfussenegger/nvim-dap",
	dependencies = "rcarriga/nvim-dap-ui",

	keys = {
		{
			"<Leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "BreakPoint",
		},
		{
			"<Leader>rr",
			function()
				require("dap").restart()
			end,
			desc = "DapRestart",
		},
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
		},
		{
			"<F6>",
			function()
				require("dap").terminate()
			end,
		},
		{
			"<Leader>lp",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
		},
		{
			"<F9>",
			function()
				require("dap").step_back()
			end,
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<Leader>B",
			function()
				require("dap").set_breakpoint()
			end,
			desc = "SetBreakpoint",
		},
		{
			"<Leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "DapRepl",
		},
		{
			"<Leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "DapLastRun",
		},
		{
			"<Leader>dh",
			function()
				require("require('dap').ui.widgets").hover()
			end,
			mode = { "n", "v" },
			desc = "DapWidgetHover",
		},
		{
			"<Leader>dp",
			function()
				require("require('dap').ui.widgets").preview()
			end,
			mode = { "n", "v" },
			desc = "DapWidgetPreview",
		},
		{
			"<Leader>df",
			function()
				local widgets = require("require('dap').ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			desc = "DapWidgetFrame",
		},
		{
			"<Leader>ds",
			function()
				local widgets = require("require('dap').ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "DapScopes",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		--dapui
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		--dapicons
		vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "" })
		vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "" })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
		--------------------------------------------------------------------------------------------------------------------------------------------------------------

		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
		}
		dap.configurations.javascript = {
			{
				name = "Launch",
				type = "node2",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				-- For this to work you need to make sure the node process is started with the `--inspect` flag.
				name = "Attach to process",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}
	end,
}
