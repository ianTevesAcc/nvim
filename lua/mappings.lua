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
      fallback()                                        -- Prevent <Enter> from confirming the completion
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

-- Define a Lua function to yank and delete the current line
function YankAndDelete()
  -- Yank the current line into the default register
  vim.cmd('normal! yy')
  -- Delete the current line into the black hole register
  vim.cmd('normal! "_dd')
end

-- Set the key mapping to call the function with the 'yd' keys in normal mode
vim.api.nvim_set_keymap('n', 'yd', ':lua YankAndDelete()<CR>', { noremap = true, silent = true })

-- Select All
vim.api.nvim_set_keymap("n", "<C-w>a", "ggVG", { noremap = true, silent = true })

-- Jump annoying closing auto pairs
vim.api.nvim_set_keymap("i", "jj", "<ESC>la", { noremap = true, silent = true })

-- Remap Shift + < and Shift + > to wait for more input
vim.api.nvim_set_keymap('x', '>', [[:execute "normal! " . v:count1 . ">>"<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<', [[:execute "normal! " . v:count1 . "<<"<CR>]], { noremap = true, silent = true })

-- For visual mode mappings, use the following for line indenting
vim.api.nvim_set_keymap('v', '>', [[:normal! >gv]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', [[:normal! <gv]], { noremap = true, silent = true })

-- Map O and o to create a new line above or below the current line and stay in normal mode
vim.api.nvim_set_keymap('n', 'O', ':execute \'normal! O\'<CR>', { noremap = true, silent = true }) -- New line above
vim.api.nvim_set_keymap('n', 'o', ':execute \'normal! o\'<CR>', { noremap = true, silent = true }) -- New line below

-- unmap ; to : normal mode escape
vim.api.nvim_del_keymap('n', ';')

-- unmap <C-c> to copy all in text file
vim.api.nvim_del_keymap('n', '<C-c>')

-- close buffers quick
vim.api.nvim_set_keymap('n', '<leader>q', ':lua CloseBuffer()<CR>', { noremap = true, silent = true })

-- close nvim quick
vim.api.nvim_set_keymap('n', '<leader>Q', ':q<CR>', { noremap = true, silent = true })

-- set X to delete character its on
vim.api.nvim_set_keymap('n', 'X', '"_x', { noremap = true, silent = true })

-- Define the function for folding based on indentation
function _G.fold_with_indent_range()
  local cur_line = vim.fn.line(".")          -- Get the current line number
  local cur_indent = vim.fn.indent(cur_line) -- Get the current line's indent

  -- Find the top of the fold
  local top_line = cur_line
  while top_line > 1 and vim.fn.indent(top_line - 1) >= cur_indent do
    top_line = top_line - 1
  end

  -- Find the bottom of the fold
  local bottom_line = cur_line
  local last_line = vim.fn.line("$") -- Get total number of lines in file
  while bottom_line < last_line and vim.fn.indent(bottom_line + 1) >= cur_indent do
    bottom_line = bottom_line + 1
  end

  -- Create fold from top_line to bottom_line
  vim.cmd(string.format("%d,%dfold", top_line, bottom_line))
end

-- Mapping to use zf for this custom fold behavior
vim.api.nvim_set_keymap('n', 'zf', ':lua fold_with_indent_range()<CR>', { noremap = true, silent = true })
