return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest",
    "leoluz/nvim-dap-go",
  },

  lazy = "VeryLazy",
  ft = { "go", "rust", "cpp", "c" },

  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    -- Hide secret tokens from showing
    require("nvim-dap-virtual-text").setup {
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)

        if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
          return "*****"
        end

        if #variable.value > 15 then
          return " " .. string.sub(variable.value, 1, 15) .. " ... "
        end

        return " " .. variable.value
      end,
    }

    -- toggle the following for debugging - (debug file  - ~/.cache/nvim/dap.log)
    require("dap").set_log_level "TRACE"

    -- Configure dap-ui with custom icons
    dapui.setup {
      icons = { expanded = "▼", collapsed = "➤", watch = "👁️" },
    }

    -- Highlight lines where breakpoints and stopped states occur
    vim.api.nvim_command "highlight DapBreakpointLine guibg=#2E3440"
    vim.api.nvim_set_hl(0, "DapBreakpointLine", { bg = "#2E3440" })
    vim.api.nvim_command "highlight DapStoppedLine guibg=#3B4252"
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#3B4252" })

    -- Automatically open/close dap-ui during the debug session
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
    -- dap.listeners.after.event_terminated["dapui_config"] = nil
    -- dap.listeners.after.event_exited["dapui_config"] = nil
    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --   pcall(dapui.open)
    -- end

    -- Define a local function for setting a watch
    local function set_watch()
      local expr = vim.fn.input "Watch variable: "
      dap.set_breakpoint(nil, nil, expr)
    end

    -- Custom restart function for dap
    local function restart()
      dap.terminate(nil, { terminateDebuggee = true }) -- Force termination
      vim.defer_fn(function() -- Delay to allow cleanup
        dap.run_last()
      end, 300) -- 300ms delay
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
    vim.keymap.set("n", "<leader>d0", restart, { desc = "Restart Debugging" })
    vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Evaluate Expression" })
    vim.keymap.set("n", "<leader>dw", set_watch, { desc = "Watch Variable" })
    vim.keymap.set("n", "<leader>dl", function()
      dap.set_breakpoint(vim.fn.input "Condition: ")
    end, { desc = "Set Conditional Breakpoint" })

    -- Load all debugger configurations
    require "plugins.debugging.debug"
  end,
}
