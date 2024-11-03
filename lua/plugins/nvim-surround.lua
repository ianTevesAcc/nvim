return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      vim.api.nvim_set_keymap("n", "+", "ysiw", { noremap = true, silent = true }),
      vim.keymap.set("v", "+", "S", { noremap = true, silent = true }),
    })
  end
}
