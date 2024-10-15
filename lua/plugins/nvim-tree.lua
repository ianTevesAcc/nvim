return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional dependency for icons
  lazy = 'VeryLazy',                                -- This ensures the plugin is loaded immediately (not lazy-loaded)

  config = function()
    require("nvim-tree").setup({
      view = {
        side = "left", -- Use "right" to position the tree on the right
      },
    })
  end,
}
