-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.g.autoformat = false
vim.opt.clipboard = "unnamedplus"

if vim.env.TMUX then
  vim.g.clipboard = {
    name = "tmux-osc52-copy",
    copy = {
      ["+"] = { vim.fn.expand("~/.local/bin/tmux-osc52-copy") },
      ["*"] = { vim.fn.expand("~/.local/bin/tmux-osc52-copy") },
    },
    paste = {
      ["+"] = function()
        return { vim.fn.getreg('"', 1, true), vim.fn.getregtype('"') }
      end,
      ["*"] = function()
        return { vim.fn.getreg('"', 1, true), vim.fn.getregtype('"') }
      end,
    },
  }
else
  vim.g.clipboard = "osc52"
end
