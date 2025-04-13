return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}

    vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle NvimTree" })
    vim.api.nvim_set_keymap('n', '<leader>E', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = "Focus File" })
  end,
}
