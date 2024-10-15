return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = 'VeryLazy',

  opts = {
    show_trailing_blankline_indent = false, -- Hide trailing blank lines
    use_treesitter = true,                  -- Use Treesitter for enhanced indent detection
  },

  main = "ibl",
  config = function()
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    -- Define highlight groups
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    -- Create highlight groups in the highlight setup hook
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    -- Set up scope highlighting
    vim.g.rainbow_delimiters = { highlight = highlight }
    ibl.setup {
      scope = { highlight = highlight }
    }

    -- Register hooks for scope highlighting
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
