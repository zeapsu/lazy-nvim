-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- better escape
map("i", "jk", "<esc>", { noremap = true, silent = true })
map("i", "jj", "<esc>", { noremap = true, silent = true })

-- command mode shortcut
map("n", ";", ":", { noremap = true, silent = true })

-- Toggle Snacks.terminal with CMD+J (mimics VSCode)
map({ "n", "t" }, "<D-j>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })

-- Create new Snacks.terminal with CTRL+` (mimics VSCode)
map({ "n", "t" }, "<C-`>", function()
  Snacks.terminal.open()
end, { desc = "New Terminal" })
