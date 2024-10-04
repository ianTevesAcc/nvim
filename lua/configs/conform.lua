local options = {
  formatters_by_ft = {
    lua = { "stylua" },              -- Lua formatting with Stylua
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

return options

