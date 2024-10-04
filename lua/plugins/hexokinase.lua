return {
  "rrethy/vim-hexokinase",
  build = "make hexokinase",

  config = function()
    vim.g.Hexokinase_highlighters = { 'virtual' }

    -- all possible values
    vim.g.Hexokinase_optInPatterns = {
      'full_hex',
      'triple_hex',
      'rgb',
      'rgba',
      'hsl',
      'hsla',
      'colour_names'
    }

    vim.g.Hexokinase_ftOptInPatterns = {
      css = 'full_hex,rgb,rgba,hsl,hsla,colour_names',
      html = 'full_hex,rgb,rgba,hsl,hsla,colour_names'
    }
  end
}

