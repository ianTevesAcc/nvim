return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()  -- Add parentheses after function
    require'nvim-treesitter.configs'.setup {  -- Call the setup function
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "latex",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "vimdoc",
        "css",
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
