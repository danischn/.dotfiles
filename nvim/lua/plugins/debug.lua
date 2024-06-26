return {
	{
		"mfussenegger/nvim-dap",
		-- stylua: ignore
		keys = {
      { "<leader>s", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<up>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<down>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<right>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
    },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
		config = function()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
