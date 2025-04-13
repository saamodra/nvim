local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local home = vim.fn.expand("~")

lspconfig.eslint.setup({
  capabilities = lsp_capabilities,
  cmd = { home .. '/.local/share/nvim/mason/bin/vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
})
