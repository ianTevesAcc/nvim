require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- load cmp & lvim plugin
local cmp = require("cmp")

-- Use tab instead of enter to select auto complete selections
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Use <Tab> to confirm completion
    ["<CR>"] = cmp.mapping(function(fallback)
      fallback() -- Prevent <Enter> from confirming the completion
    end, { "i", "s" }),
  },
})

-- Use jk to exit insert mode and enter normal mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })


-- Allow cursor to more to next or previous line when at past end or beginning of line
vim.opt.whichwrap:append("<,>,h,l")

-- Delete Arrow Functionality
-- Disable arrow keys
vim.api.nvim_set_keymap("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "<Nop>", { noremap = true, silent = true })
-- If you also want to disable arrow keys in insert mode
vim.api.nvim_set_keymap("i", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Right>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Down>", "<Nop>", { noremap = true, silent = true })

-- Disable vim-cmp Up and Down selection
cmp.setup({
  mapping = {
    ["<Up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      end
      fallback()
    end, { "i" }),
    ["<Down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      end
      fallback()
    end, { "i" }),
  },
})

-- Define a command named "ToggleTransparency"
vim.api.nvim_create_user_command('ToggleTransparency', 'lua require("base46").toggle_transparency()', {})

-- Map the <leader>tt key to the ToggleTransparency command
vim.api.nvim_set_keymap("n", "<leader>tt", ":ToggleTransparency<CR>", { noremap = true, silent = true })


-- Define a command named "ToggleTransparency"
vim.api.nvim_create_user_command('ToggleTheme', 'lua require("base46").toggle_theme()', {})
vim.api.nvim_set_keymap("n", "<leader>ts", ":ToggleTheme<CR>", { noremap = true, silent = true })

-- Toggle Dashboard
vim.api.nvim_set_keymap("n", "<leader>dd", ":Nvdash<CR>", { noremap = true, silent = true })

-- Center cursor when navigating
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "G", "Gzz", { noremap = true, silent = true })

-- Delete without affecting the default register
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true, silent = true })

-- Paste without saving to the default register
vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })

-- Yank and delete without affecting the default register
vim.api.nvim_set_keymap("n", "yd", 'yy"_d', { noremap = true, silent = true })

-- Select All
vim.api.nvim_set_keymap("n", "<C-w>a", "ggVG", { noremap = true, silent = true })

-- Jump annoying closing auto pairs
vim.api.nvim_set_keymap("i", "jl", "<ESC>la", { noremap = true, silent = true })
