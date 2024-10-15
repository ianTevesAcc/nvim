return {
  "stevearc/conform.nvim",
  opts = require "configs.conform",
  event = 'BufWritePre', -- uncomment for format on save
  lazy = true,

}
