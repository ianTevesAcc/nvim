return {
  "ggandor/flit.nvim",
  dependencies = {
    "ggandor/leap.nvim",
    "tpope/vim-repeat",
  },
  lazy = 'VeryLazy', -- Disable lazy loading for testing

  config = function()
    -- Set up leap.nvim with default keymaps
    require('leap').set_default_keymaps()

    -- Flit setup
    require('flit').setup {
      keys = { f = 'f', F = 'F', t = 't', T = 'T' },
      labeled_modes = "nv", -- Enable in normal and visual modes
      clever_repeat = true,
      multiline = false,    -- Limit search to the current line
      opts = {
        -- You can add specific options here if needed
      },
    }

    -- Additional leap configuration (if needed)
    require('leap').setup {
      highlight_unlabeled = true, -- Enable highlighting for unlabeled targets
      highlight_on_jump = true,   -- Optional: highlight the target when jumping
    }
  end,
}
