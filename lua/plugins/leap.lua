return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat"
  },

  config = function()
    local leap = require('leap')
    local leap_treesitter = require('leap.treesitter')
    local leap_remote = require('leap.remote')

    -- Unmap the default 's' and 'S' in normal, visual, and operator-pending modes
    vim.keymap.set({'n', 'x', 'o'}, 's', '')
    vim.keymap.set({'n', 'x', 'o'}, 'S', '')

    -- Key mappings for Leap
    vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)', { noremap = true })
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)', { noremap = true })
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)', { noremap = true })

    -- Define equivalence classes for brackets, quotes, and whitespace
    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

    -- Use traversal keys to repeat the previous Leap motion
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')

    -- Incremental treesitter node selection
    vim.keymap.set({'n', 'x', 'o'}, 'ga', function()
      leap_treesitter.select()
    end)

    -- Linewise selection
    vim.keymap.set({'n', 'x', 'o'}, 'gA', function()
      vim.cmd([[normal! V]])
      leap_treesitter.select()
    end)

    -- Remote operations (spooky actions at a distance)
    vim.keymap.set({'n', 'o'}, 'gS', function()
      leap_remote.action()
    end)
  end,
}
