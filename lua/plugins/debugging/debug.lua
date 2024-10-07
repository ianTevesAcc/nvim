-- ~/.config/nvim/lua/debugging/debug.lua
local dap = require('dap')

-- Load debugger configurations based on filetype
local filetype = vim.bo.filetype

if filetype == "cpp" or filetype == "c" then
  require('plugins.debugging.debuggers.cpp')  -- Load C/C++ debugger configurations
elseif filetype == "rust" then
  require('plugins.debugging.debuggers.rust')  -- Load Rust debugger configurations
elseif filetype == "go" then
  require('plugins.debugging.debuggers.go')  -- Load Go debugger configurations
end
