return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/neotest",
    "nvim-neotest/nvim-nio",

    -- Place all language debuggers inside here
    -- Plugins here are only loaded when editing relative file type
    {
      {     "leoluz/nvim-dap-go",
        ft = "go",
        config = function()
          require('dap-go').setup()
        end,
      },
    },
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- Configure dap-ui with custom icons
    dapui.setup({
      icons = { expanded = "⏬", collapsed = "⏩" },
      mappings = {},
    })

    -- Automatically open/close dap-ui during the debug session
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.after.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.after.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Set up dap keymaps for essential debugging actions
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Evaluate Expression" })
    vim.keymap.set("n", "<leader>dk", dap.terminate, { desc = "Terminate Debugging" })
    vim.keymap.set("n", "<leader>db", function()
      dap.clear_breakpoints()
    end, { desc = "Clear Breakpoints" })

    -- Optional: Add a keymap for setting conditional breakpoints
    vim.keymap.set("n", "<leader>dl", function()
      dap.set_breakpoint(vim.fn.input('Condition: '))
    end, { desc = "Set Conditional Breakpoint" })

    -- Highlight lines where breakpoints and stopped states occur
    vim.api.nvim_command('highlight DapBreakpointLine guibg=#2E3440')
    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

    vim.api.nvim_command('highlight DapStoppedLine guibg=#3B4252')
    vim.fn.sign_define('DapStopped', { text = '⚪', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStopped' })
  end,
}
