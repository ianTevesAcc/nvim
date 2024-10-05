-- Function to trim trailing whitespace
local function trim_trailing_whitespace()
  vim.cmd([[
    %s/\s\+$//e
    ]])
end

-- Function to remove empty start and end lines
local function trim_file_edges()
  vim.cmd([[
    silent! %s/\%^\n\+//e
    silent! %s/\n\+\%$//e
    ]])
end

-- Function to fix indentations while preserving cursor position
local function fix_indentations_preserve_cursor()
  -- Save the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  -- Perform the indentation fix
  vim.cmd("normal! gg=G")

  -- Restore the cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- Module setup snippet with formatting hooks
local options = {
  formatters_by_ft = {
    lua = { "prettier" },            -- Lua formatting with Stylua
    css = { "prettier" },            -- CSS formatting with Prettier
    html = { "prettier" },           -- HTML formatting with Prettier
    javascript = { "prettier" },     -- JavaScript formatting with Prettier
    typescript = { "prettier" },     -- TypeScript formatting with Prettier
    python = { "black" },            -- Python formatting with Black
    json = { "prettier" },           -- JSON formatting with Prettier
    -- Add more languages/formatters as needed
  },

  format_on_save = {
    timeout_ms = 500,                -- Timeout for formatting operations
    lsp_fallback = true,             -- Use LSP formatting if no formatter is found
  },
}

-- Attach the trim functions and indentation fix to the BufWritePre event
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    trim_trailing_whitespace()
    trim_file_edges()
    fix_indentations_preserve_cursor()  -- Use the modified function
  end,
})

return options
