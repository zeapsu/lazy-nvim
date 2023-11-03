-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local g = vim.g

-- nvim options
-- opt.winbar = "%=%m %f"
opt.swapfile = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.textwidth = 80
-- opt.colorcolumn = "+1"
opt.columns = 80

-- plugin options
g.vimtex_view_method = "sioyek"
