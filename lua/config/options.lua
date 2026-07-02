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

-- Use OSC 52 for clipboard over SSH
if vim.env.SSH_TTY then
  g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- yank to clipboard
opt.clipboard = "unnamedplus"

-- theme options
opt.background = "light"

-- plugin options
g.vimtex_view_method = "sioyek"
-- AI completion: use inline Copilot ghost text instead of the cmp menu source
g.ai_cmp = false

-- Molten: point Neovim's remote plugin host at the dedicated venv
-- (keeps pynvim/jupyter_client isolated from project venvs)
g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
