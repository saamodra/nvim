local Plugins = {
  -- Git Plugins
  { 'tpope/vim-fugitive' },

  -- Editing Enhancements
  { 'wellle/targets.vim', lazy = true },
  { 'mg979/vim-visual-multi', event = 'VeryLazy' },
  { 'slim-template/vim-slim', ft = 'slim' },
  { 'numToStr/Comment.nvim', config = true, event = 'VeryLazy' },

  -- LSP & Autocompletion
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-compe', event = 'InsertEnter' },
  { 'onsails/lspkind.nvim', lazy = true },

  -- Testing
  { 'vim-test/vim-test', cmd = { 'TestNearest', 'TestFile', 'TestSuite' } },

  -- Mini Plugins
  { 'echasnovski/mini.move', lazy = true },
  { 'echasnovski/mini.pairs', event = 'InsertEnter' },
  { 'echasnovski/mini.trailspace', lazy = true },

  -- Better Motion
  { 'chrisgrieser/nvim-spider', lazy = true },

  -- Icons (Required by other plugins)
  { 'kyazdani42/nvim-web-devicons', lazy = true },

  -- Theme (Should load first)
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, lazy = false }
}

return Plugins
