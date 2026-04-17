-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.g.autoformat = false
vim.opt.clipboard = "unnamedplus"

local function osc52_copy(lines)
  local text = table.concat(lines, "\n")
  local b64 = vim.base64.encode(text)

  local seq
  if vim.env.TMUX then
    seq = "\x1bPtmux;\x1b\x1b]52;c;" .. b64 .. "\x07\x1b\\"
  else
    seq = "\x1b]52;c;" .. b64 .. "\x07"
  end

  io.stdout:write(seq)
  io.stdout:flush()
end

vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = osc52_copy,
    ["*"] = osc52_copy,
  },
  paste = {
    ["+"] = function()
      return { vim.fn.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
    end,
    ["*"] = function()
      return { vim.fn.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
    end,
  },
}

