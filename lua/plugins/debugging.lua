return {
  "williamboman/mason.nvim",
  "mfussenegger/nvim-dap",
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/neotest",
    "nvim-neotest/nvim-nio",
    {
      "leolux/nvim-dap-go",
      ft = "go",
      config = function()
        require("dap-go").setup()
      end,
    }
  },
  lazy = 'VeryLazy',

  -- Use ft to trigger the loading on specific file types
  ft = { "rust", "cpp", "c" },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    -- Configure dap-ui with custom icons
    dapui.setup({
      icons = { expanded = "▼", collapsed = "➤", watch = "👁️" },
      mappings = {},
    })

    -- Highlight lines where breakpoints and stopped states occur
    vim.api.nvim_command('highlight DapBreakpointLine guibg=#2E3440')
    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

    vim.api.nvim_command('highlight DapStoppedLine guibg=#3B4252')
    vim.fn.sign_define('DapStopped',
      { text = '⚪', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStopped' })

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

    -- Function for setting a watch on a variable
    function _G.set_watch()
      local expr = vim.fn.input('Watch variable: ')
      dap.set_breakpoint(nil, nil, expr)
    end

    -- Set up dap keymaps for essential debugging actions
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>db", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
    vim.keymap.set("n", "<leader>dk", dap.terminate, { desc = "Terminate Debugging" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<leader>d1", dap.continue, { desc = "Continue Debugging" })
    vim.keymap.set("n", "<leader>d2", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>d3", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>d4", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>d5", dap.step_back, { desc = "Step Back" })
    vim.keymap.set("n", "<leader>d0", dap.restart, { desc = "Step Restart" })
    vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Evaluate Expression" })
    vim.keymap.set('n', '<leader>dw', set_watch, { desc = "Watch Variable" })
    vim.keymap.set("n", "<leader>dl", function()
      dap.set_breakpoint(vim.fn.input('Condition: '))
    end, { desc = "Set Conditional Breakpoint" })

    -- Load all debugger configurations
    require('plugins.debugging.debug')
  end,
}
