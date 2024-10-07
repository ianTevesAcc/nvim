local dap = require('dap')

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/ian/Downloads/debuggers/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  -- 1: Debug without arguments
  {
    name = "Debug",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },

  -- 2: Debug with Arguments
  {
    name = "Debug (Arguments)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    args = function()
      return vim.fn.split(vim.fn.input('Arguments: '), " ")
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },

  -- 3: Debug with Arguments and Build Flags
  {
    name = "Debug (Arguments & Build Flags)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    args = function()
      return vim.fn.split(vim.fn.input('Arguments: '), " ")
    end,
    buildFlags = function()
      return vim.fn.split(vim.fn.input('Build Flags: '), " ")
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },

  -- 4: Debug Package (Folder)
  {
    name = "Debug Package",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = function()
      return vim.fn.input('Path to package (folder): ', vim.fn.getcwd(), 'dir')
    end,
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },

  -- 5: Attach to running process (gdbserver)
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/home/linuxbrew/.linuxbrew/bin/gdb",
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },

  -- 6: Debug Test (assuming you have a separate test executable)
  {
    name = "Debug Test",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },

  -- 7: Debug test with specific go.mod or similar (can be customized for C++ test frameworks)
  {
    name = "Debug Test (Specific)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
    buildFlags = function()
      return vim.fn.input('Enter specific flags: ')
    end,
  },
}
