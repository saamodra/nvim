return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.install").compilers = { "gcc" }

    opts.ensure_installed = {
      "bash",
      "c",
      "html",
      "lua",
      "markdown",
      "vim",
      "vimdoc",
      "python",
      "ruby",
      "javascript",
      "json",
    }

    return opts
  end,
}
