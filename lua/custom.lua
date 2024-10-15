-- etpos('.', save_cursor)tpos('.', save_cursor)- Enable both relative and absolute line numbers
vim.wo.number = true         -- Show absolute line number
vim.wo.relativenumber = true -- Show relative line numbers

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

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  group = "AutoFormat",
  callback = function()
    local cursor_pos = vim.fn.getpos "." -- Save current cursor position
    vim.cmd "silent !black --quiet %"
    vim.cmd "edit"                       -- Reloads the buffer
    vim.fn.setpos(".", cursor_pos)       -- Restore the cursor position
  end,
})

-- Function to copy the current file path to clipboard
local function copy_file_path()
  -- Get the current file path
  local file_path = vim.fn.expand "%:p"

  -- Copy the file path to the clipboard
  vim.fn.setreg("+", file_path)

  -- Notify the user
  print('Copied "' .. file_path .. '" to clipboard')
end

-- Create a command named Cppath
vim.api.nvim_create_user_command("Cppath", copy_file_path, {})

-- Function to close the current buffer and delete unnamed buffers
function CloseBuffer()
  local current_buffer = vim.api.nvim_get_current_buf()
  -- Close the buffer
  vim.cmd('bd')

  -- Check if the buffer is unnamed and delete it
  local bufnr = vim.fn.bufnr('%')
  if vim.fn.bufname(bufnr) == '' then
    vim.cmd('bd ' .. bufnr)
  end
end

-- Map the function to a command
vim.api.nvim_create_user_command('CloseBuf', CloseBuffer, {})
