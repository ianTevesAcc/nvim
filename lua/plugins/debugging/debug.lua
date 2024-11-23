-- Load debugger config based on filetype
local filetype = vim.bo.filetype

if filetype == "cpp" or filetype == "c" then
  require "plugins.debugging.debuggers.cpp" -- load C/C++ debugger conf
elseif filetype == "rust" then
  require "plugins.debugging.debuggers.rust" -- load Rust debugger conf
elseif filetype == "go" then
  require("dap-go").setup() -- load Go debugger plugin
end
