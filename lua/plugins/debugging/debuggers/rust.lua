local dap = require('dap')

-- Configure the dap adapter for Rust using the cppdbg adapter
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/ian/Downloads/debuggers/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

-- Configure Rust debugging
dap.configurations.rust = {
  {
    name = "Launch Rust",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'attach',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/home/linuxbrew/.linuxbrew/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
