return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat"
  },
  event = 'VeryLazy',

  config = function()
    local leap = require('leap')
    local leap_treesitter = require('leap.treesitter')
    local leap_remote = require('leap.remote')

    -- Define equivalence classes for brackets, quotes, and whitespace
    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

    -- Key mappings for Leap
    vim.keymap.set('n', 's', '<Plug>(leap)', { noremap = true })
    vim.keymap.set('n', 'S', '<Plug>(leap-from-window)', { noremap = true })

    -- Use traversal keys to repeat the previous Leap motion
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')

    -- Incremental treesitter node selection
    vim.keymap.set({ 'n', 'x', 'o' }, 'ga', function()
      leap_treesitter.select()
    end)

    -- Linewise selection
    vim.keymap.set({ 'n', 'x', 'o' }, 'gA', function()
      vim.cmd([[normal! V]]) -- Enter visual line mode
      leap_treesitter.select()
    end)

    -- Remote operations (spooky actions at a distance)
    vim.keymap.set({ 'n', 'o' }, 'gS', function()
      leap_remote.action()
    end)

    -- The below settings make Leap's highlighting closer to what you've been
    -- used to in Lightspeed.

    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
    vim.api.nvim_set_hl(0, 'LeapMatch', {
      -- For light themes, set to 'black' or similar.
      fg = 'white',
      bold = true,
      nocombine = true,
    })
    -- Deprecated option. Try it without this setting first, you might find
    -- you don't even miss it.
    require('leap').opts.highlight_unlabeled_phase_one_targets = true

    -- Or just set to grey directly, e.g. { fg = '#777777' },
    -- if Comment is saturated.
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

    -- Hide the (real) cursor when leaping, and restore it afterwards.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LeapEnter',
      callback = function()
        vim.cmd.hi('Cursor', 'blend=100')
        vim.opt.guicursor:append { 'a:Cursor/lCursor' }
      end,
    }
    )
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LeapLeave',
      callback = function()
        vim.cmd.hi('Cursor', 'blend=0')
        vim.opt.guicursor:remove { 'a:Cursor/lCursor' }
      end,
    }
    )
  end,

}
