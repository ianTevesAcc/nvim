return {
  "kyazdani42/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "right",  -- Use "right" to position the tree on the right
      },
    })
  end,
}
