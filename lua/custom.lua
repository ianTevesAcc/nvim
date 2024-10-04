-- Enable both relative and absolute line numbers
vim.wo.number = true           -- Show absolute line number
vim.wo.relativenumber = true   -- Show relative line numbers

-- Change local directory on buffer enter
local autocmd = vim.api.nvim_create_autocmd

-- Wrap Comments and Lines
vim.cmd [[autocmd FileType * set formatoptions-=cro]]

-- Set the local working directory to the current file's directory (excluding terminal buffers)
autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.cmd "lcd %:p:h"
    end
  end,
})

-- Create an autocommand group named "AutoFormat"
vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = "*.py",
    group = "AutoFormat",
    callback = function()
      vim.cmd("silent !black --quiet %")
      vim.cmd("edit")
    end,
  }
)

-- Remove trailing whitespaces on save
vim.cmd [[
  autocmd BufWritePre * %s/\s\+$//e
]]

-- Ensure there's always one, and only one, newline at the end of the file
vim.cmd [[
  autocmd BufWritePre * %s/\n\+\%$//e | normal Go
]]

-- Auto indent and format the file on save
vim.cmd [[
  autocmd BufWritePre * normal gg=G
]]

-- Function to copy the current file path to clipboard
local function copy_file_path()
  -- Get the current file path
  local file_path = vim.fn.expand('%:p')

  -- Copy the file path to the clipboard
  vim.fn.setreg('+', file_path)

  -- Notify the user
  print("Copied \"" .. file_path .. "\" to clipboard")
end

-- Create a command named Cppath
vim.api.nvim_create_user_command('Cppath', copy_file_path, {})

