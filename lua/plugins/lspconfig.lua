local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
  {'hrsh7th/cmp-nvim-lsp'},
  {'williamboman/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.init()
  local sign = function(opts)
    -- See :help sign_define()
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({name = 'DiagnosticSignError', text = '✘'})
  sign({name = 'DiagnosticSignWarn', text = '▲'})
  sign({name = 'DiagnosticSignHint', text = '⚑'})
  sign({name = 'DiagnosticSignInfo', text = '»'})

  -- See :help vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = true
    },
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
end

function Plugin.config()
  local lspconfig = require('lspconfig')
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

  local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = user.on_attach
  })

  -- See :help mason-lspconfig-settings
  require('mason-lspconfig').setup({
    ensure_installed = {
      'eslint',
			'ts_ls',
      'html',
      'cssls',
      'ruby_lsp',
      'lua_ls',
      'tailwindcss'
    },
    handlers = {
      -- See :help mason-lspconfig-dynamic-server-setup
      function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({
          capabilities = lsp_capabilities,
        })
      end,
      ['ts_ls'] = function()
        lspconfig.ts_ls.setup({
          capabilities = lsp_capabilities,
          settings = {
            completions = {
              completeFunctionCalls = true
            }
          }
        })
      end,
      ['tailwindcss'] = function()
        lspconfig.tailwindcss.setup {}
      end,
      ['lua_ls'] = function()
        require('plugins.lsp.lua_ls')
      end,
			['eslint'] = function()
        require('plugins.lsp.eslint')
			end
    }
  })
end

function user.on_attach()
  local bufmap = function(mode, lhs, rhs, desc)
    local opts = { buffer = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- You can search each function in the help page.
  -- For example :help vim.lsp.buf.hover()
  bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', "Hover (Show documentation)")
  bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', "Go to Definition")
  bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', "Go to Declaration")
  bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', "Go to Implementation")
  bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', "Go to Type Definition")
  bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', "Find References")
  bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', "Signature Help")
  bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', "Rename Symbol")
  bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', "Format Code")
  bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', "Code Action")
  bufmap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', "Code Action")
  bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', "Show Diagnostic Float")
  bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', "Go to Previous Diagnostic")
  bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', "Go to Next Diagnostic")
end

return Plugin

