return {
  'sethen/line-number-change-mode.nvim',
  lazy = false,
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Load before other plugins to apply theme first
  },
  config = function()
    require('catppuccin').setup({
      fravour = 'mocha',
    });
    local palette = require('catppuccin.palettes').get_palette('mocha')

    if (palette == nil) then
      return nil
    end

    require("line-number-change-mode").setup({
      i = {
        bg = palette.green,
        fg = palette.mantle,
        bold = true,
      },
      n = {
        bg = palette.blue,
        fg = palette.mantle,
        bold = true,
      },
      R = {
        bg = palette.maroon,
        fg = palette.mantle,
        bold = true,
      },
      v = {
        bg = palette.mauve,
        fg = palette.mantle,
        bold = true,
      },
      V = {
        bg = palette.mauve,
        fg = palette.mantle,
        bold = true,
      },
    })
  end
}
