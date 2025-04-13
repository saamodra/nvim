return {
  'stevearc/aerial.nvim',
  opts = {},
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup({
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      layout = {
        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        max_width = { 50, 0.25 },
        width = nil,
        min_width = 20,
      },
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })

    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { noremap = true, silent = true, desc = "Toggle Aerial" })
  end,
}
