local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.settings')
load('user.commands')
load('user.keymaps')
require('user.plugins')
require('lsp')

pcall(vim.cmd.colorscheme, 'catppuccin-mocha')
