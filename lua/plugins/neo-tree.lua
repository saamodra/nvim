return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          reveal = true,
          position = "left",
        })
      end,
      desc = "Explorer NeoTree (reveal current file)",
    },
  },
}
