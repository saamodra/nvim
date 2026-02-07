-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = require('utils.map').map

map('n', '<leader>yp', '<cmd>lua CopyRelativeFilePath()<cr>', "Copy relative file path")
map('n', '<leader>cw', '<cmd>lua StripTrailingWhitespaces()<cr>', "Strip trailing whitespaces")

vim.keymap.set("n", "<C-p>", LazyVim.pick("files"), { desc = "Find Files" })
