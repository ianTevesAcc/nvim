-- ~/.config/nvim/lua/debugging/debuggers/go.lua
return {
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    config = function()
      require('dap-go').setup()  -- Set up the nvim-dap-go plugin
    end,
  },
}
