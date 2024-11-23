local dap = require "dap"

-- Configure the codelldb adapter
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/home/ian/9 files/debuggers/CC++Rust(via-codelldb)/adapter/codelldb",
    args = { "--port", "${port}" },
  },
}

-- Function to compile a C++ file
local function compile_cpp()
  local cpp_file = vim.fn.input "Enter the C++ source file (e.g., my_program.cpp): "
  local executable_name = vim.fn.input("Enter the name for the executable: ", "my_program")
  local command = string.format("g++ -g -o %s %s", executable_name, cpp_file)

  local result = os.execute(command)
  if result == 0 then
    print("Compilation successful: " .. executable_name)
    return executable_name
  else
    print "Compilation failed."
    return nil
  end
end

-- DAP configurations for C++
dap.configurations.cpp = {
  -- Manual Debug Configuration
  {
    name = "Manual Debug",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Automatic Debug Configuration
  {
    name = "Automatic Debug",
    type = "cppdbg",
    request = "launch",
    program = function()
      local executable_name = "my_program" -- Default executable name
      local executable_path = vim.fn.getcwd() .. "/" .. executable_name

      -- Check if the executable exists
      if vim.fn.filereadable(executable_path) == 1 then
        print("Found existing executable: " .. executable_name)
        return executable_path
      else
        local choice = vim.fn.input "Executable not found. Compile new executable? (y/n): "
        if choice:lower() == "y" then
          return compile_cpp() -- Compile and return the new executable path
        else
          print "Debugging failed: No executable found."
          return nil
        end
      end
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Debug without arguments
  {
    name = "Debug (no args)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
    miDebuggerPath = "/usr/bin/gdb", -- Adjust this path if necessary
  },
  -- Debug with arguments
  {
    name = "Debug (with args)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    args = function()
      return vim.fn.split(vim.fn.input "Arguments: ", " ")
    end,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Debug with arguments and build flags
  {
    name = "Debug (args & build flags)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    args = function()
      return vim.fn.split(vim.fn.input "Arguments: ", " ")
    end,
    buildFlags = function()
      return vim.fn.split(vim.fn.input "Build flags: ", " ")
    end,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Debug a package (folder)
  {
    name = "Debug Package",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = function()
      return vim.fn.input("Path to package (folder): ", vim.fn.getcwd(), "dir")
    end,
    stopAtEntry = true,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Attach to running process (gdbserver)
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    miMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb", -- Adjust this path if necessary
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Debug a test executable
  {
    name = "Debug Test",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
  },
  -- Debug a test with specific flags
  {
    name = "Debug Test (specific)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      { text = "-enable-pretty-printing", description = "Enable pretty printing", ignoreFailures = false },
    },
    buildFlags = function()
      return vim.fn.input "Enter specific flags: "
    end,
  },
}

-- CODE FOR CPPDBG
-- dap.adapters.cppdbg = {
--   id = "cppdbg",
--   type = "executable",
--   command = "/home/ian/9 files/debuggers/vscode-cpptools-1.22.11(patch-update)/debugadapters/bin/opendebugad7",
-- }

-- dap.configurations.cpp = {
--   -- 1: debug without arguments
--   {
--     name = "debug",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspacefolder}",
--     stopatentry = true,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--     midebuggerpath = "/usr/bin/gdb",
--   },
--
--   -- 2: debug with arguments
--   {
--     name = "debug (arguments)",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspacefolder}",
--     stopatentry = true,
--     args = function()
--       return vim.fn.split(vim.fn.input "arguments: ", " ")
--     end,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--   },
--
--   -- 3: debug with arguments and build flags
--   {
--     name = "debug (arguments & build flags)",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspacefolder}",
--     stopatentry = true,
--     args = function()
--       return vim.fn.split(vim.fn.input "arguments: ", " ")
--     end,
--     buildflags = function()
--       return vim.fn.split(vim.fn.input "build flags: ", " ")
--     end,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--   },
--
--   -- 4: debug package (folder)
--   {
--     name = "debug package",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = function()
--       return vim.fn.input("path to package (folder): ", vim.fn.getcwd(), "dir")
--     end,
--     stopatentry = true,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--   },
--
--   -- 5: attach to running process (gdbserver)
--   {
--     name = "attach to gdbserver :1234",
--     type = "cppdbg",
--     request = "launch",
--     mimode = "gdb",
--     midebuggerserveraddress = "localhost:1234",
--     midebuggerpath = "/home/linuxbrew/.linuxbrew/bin/gdb",
--     cwd = "${workspacefolder}",
--     program = function()
--       return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--   },
--
--   -- 6: debug test (assuming you have a separate test executable)
--   {
--     name = "debug test",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("path to test executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspacefolder}",
--     stopatentry = true,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--   },
--
--   -- 7: debug test with specific go.mod or similar (can be customized for c++ test frameworks)
--   {
--     name = "debug test (specific)",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("path to test executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspacefolder}",
--     stopatentry = true,
--     setupcommands = {
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignorefailures = false,
--       },
--     },
--     buildflags = function()
--       return vim.fn.input "enter specific flags: "
--     end,
--   },
-- }
