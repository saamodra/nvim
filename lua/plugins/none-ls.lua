return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local vscode_config = require("utils.vscode-config")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        if vscode_config.is_enabled("editor.formatOnSave") then
          vim.lsp.buf.format({ async = false })
        end
      end,
    })
  end,
}
