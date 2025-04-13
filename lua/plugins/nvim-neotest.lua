return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
    'nvim-neotest/neotest-jest',
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-rspec")({
          rspec_cmd = function()
            return vim.tbl_flatten({
              "docker",
              "compose",
              "exec",
              "web",
              "bin/rspec",
            })
          end,

          transform_spec_path = function(path)
            local prefix = require('neotest-rspec').root(path)
            return string.sub(path, string.len(prefix) + 2, -1)
          end,

          results_path = "tmp/rspec.output",
          formatter = "json"
        }),
      },
      discovery = {
        enabled = false,
      },
    })
  end
}
