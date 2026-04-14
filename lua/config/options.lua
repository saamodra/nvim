-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.g.autoformat = false
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = function(lines, _)
      local text = table.concat(lines, "\n")
      local b64 = vim.fn.system("base64", text):gsub("\n", "")
      local tty
      if vim.env.TMUX then
        tty = vim.fn.system("tmux display-message -p '#{client_tty}'"):gsub("\n", "")
      else
        tty = vim.env.SSH_TTY or io.open("/dev/tty", "w")
      end
      local f = io.open(tty, "w")
      if f then
        f:write("\x1b]52;c;" .. b64 .. "\a")
        f:close()
      end
    end,
    ["*"] = function(lines, _)
      local text = table.concat(lines, "\n")
      local b64 = vim.fn.system("base64", text):gsub("\n", "")
      local tty
      if vim.env.TMUX then
        tty = vim.fn.system("tmux display-message -p '#{client_tty}'"):gsub("\n", "")
      else
        tty = vim.env.SSH_TTY or "/dev/tty"
      end
      local f = io.open(tty, "w")
      if f then
        f:write("\x1b]52;c;" .. b64 .. "\a")
        f:close()
      end
    end,
  },
  paste = {
    ["+"] = function()
      return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
    end,
    ["*"] = function()
      return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
    end,
  },
}

