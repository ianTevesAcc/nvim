return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = 'VeryLazy',

  config = function()                         -- Add parentheses after function
    require 'nvim-treesitter.configs'.setup { -- Call the setup function
      ensure_installed = {
        "bash",
        "sql",
        "go",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "latex",
        "java",
        "cpp",
        "csv",
        "python",
        "query",
        "regex",
        "tsx",
        "vim",
        "yaml",
        "dockerfile",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
