return {
  "ziontee113/color-picker.nvim",
  config = function()
    local opts = { noremap = true, silent = true }

    -- Key mappings for color picker
    vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
    vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

    vim.keymap.set("n", "<leader>cp", "<cmd>PickColor<cr>", opts)
    vim.keymap.set("i", "<leader>cp", "<cmd>PickColorInsert<cr>", opts)


    -- Optional key mappings for conversions
    -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
    -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

    -- Setup the color-picker with custom options
    require("color-picker").setup({
      -- Icons customization
      -- ["icons"] = { "ﱢ", "" },
      -- ["icons"] = { "ﮊ", "" },
      -- ["icons"] = { "", "ﰕ" },
      -- ["icons"] = { "", "" },
      -- ["icons"] = { "ﱢ", "" },
      ["icons"] = { "", "" },
      ["border"] = "rounded", -- options: none | single | double | rounded | solid | shadow
      ["keymap"] = { -- Custom key mappings for the color picker
        ["U"] = "<Plug>ColorPickerSlider5Decrease",
        ["O"] = "<Plug>ColorPickerSlider5Increase",
      },
      ["background_highlight_group"] = "Normal", -- default
      ["border_highlight_group"] = "FloatBorder", -- default
      ["text_highlight_group"] = "Normal", -- default
    })
  end,
  lazy = 'VeryLazy',
}
