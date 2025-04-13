return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps",
    },
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "Telescope" },
      { "<leader>fo", desc = "Recently Opened Files" },
      { "<leader>fb", desc = "Open Buffers" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" },
      { "<leader>fd", desc = "Diagnostics" },
      { "<leader>fs", desc = "Search in Buffer" },

      { "<leader>g", group = "Git" },
      { "<leader>gs", desc = "Git Status" },
      { "<leader>gh", desc = "Git Changes" },
      { "<leader>gd", desc = "Git Diff" },
      { "<leader>gb", desc = "Git Branch" },
      { "<leader>gr", desc = "Git Read (Checkout File)" },
      { "<leader>gw", desc = "Git Write (Stage File)" },
      { "<leader>ge", desc = "Git Edit (Open File in Index)" },
      { "<leader>gc", desc = "Github Copilot Chat" },

      { "<leader>t", group = "Test" },
      { "<leader>tf", desc = "Run Test Vim-Test" },
      { "<leader>tr", desc = "Run Test" },
      { "<leader>tt", desc = "Run Test on Current File" },
      { "<leader>ts", desc = "Toggle Test Summary" },
      { "<leader>ta", desc = "Attach to Test" },

      { "<leader>a", icon = "" },
      { "<leader>b", group = "Buffer", icon = "󰀼" },
      { "<leader>c", group = "Custom Commands", icon = "" },
      { "<leader>e", icon = "", desc = "File Explorer" },
      { "<leader>E", icon = "", desc = "Focus File" },
      { "<leader>t", icon = "󰂖" },
      { "<leader>ta", icon = "󰁦" },
      { "<leader>tc", icon = "󰙧" },
      { "<leader>tf", icon = "" },
      { "<leader>tr", icon = "" },
      { "<leader>y", icon = "󰆏" },
      { "<leader>yr", icon = "󰆏" },
      { "<leader>yp", icon = "󰆏" },

      { "<leader>?", icon = "󰋗" },
    })
  end,
}
