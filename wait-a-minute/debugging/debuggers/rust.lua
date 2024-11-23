local dap = require "dap"

-- Use the cppdbg adapter for Rust debugging
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "/home/ian/9 files/debuggers/CC++Rust(codelldb)/debugAdapters/bin/OpenDebugAD7.exe",
}

-- Configure Rust debugging with multiple options
dap.configurations.rust = {
  -- 1: Launch without Arguments
  {
    name = "Launch Rust",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing",
        ignoreFailures = false,
      },
    },
  },

  -- 2: Launch with Arguments
  {
    name = "Launch Rust (Arguments)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    args = function()
      return vim.fn.split(vim.fn.input "Arguments: ", " ")
    end,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing",
        ignoreFailures = false,
      },
    },
  },

  -- 3: Launch with Arguments and Build Flags
  {
    name = "Launch Rust (Arguments & Build Flags)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    args = function()
      return vim.fn.split(vim.fn.input "Arguments: ", " ")
    end,
    buildFlags = function()
      return vim.fn.split(vim.fn.input "Build Flags: ", " ")
    end,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing",
        ignoreFailures = false,
      },
    },
  },

  -- 4: Attach to gdbserver
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "attach",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/home/linuxbrew/.linuxbrew/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
  },

  -- 5: Debug Rust Test
  {
    name = "Debug Rust Test",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing",
        ignoreFailures = false,
      },
    },
  },

  -- 6: Debug Rust Test with Specific Options
  {
    name = "Debug Rust Test (Specific Flags)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    buildFlags = function()
      return vim.fn.input "Enter build flags: "
    end,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "Enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
}
