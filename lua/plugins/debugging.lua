return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    -- Lazy-load nvim-dap-go only for Go filetype
    {
      "leoluz/nvim-dap-go",
      ft = "go",
      -- Load only when editing Go files
      config = function()
        require('dap-go').setup() -- Setup for nvim-dap-go
      end,
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dap-go").setup()

    -- Configure nvim-dap-ui
    dapui.setup({
      icons = { expanded = "⏬", collapsed = "⏩" },
      mappings = {
        -- Use these mappings to navigate the UI
      },
      -- Customize layouts, controls, and windows
    })

    -- Open dap-ui automatically
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Load dap keymaps
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

    -- Set distinct colors for breakpoints
    vim.api.nvim_command('highlight DapBreakpointLine guibg=#2E3440')
    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

    -- Additional signs for more clarity
    vim.api.nvim_command('highlight DapStoppedLine guibg=#3B4252')
    vim.fn.sign_define('DapStopped', { text = '⚪', texthl = 'DapStopped', linehl = '', numhl = '' })
  end,
}
