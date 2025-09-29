-- LSP Configuration using built-in vim.lsp.config API
local function setup_lsp()
  -- Configure diagnostics with custom signs
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = true
    },
    signs = {
      Error = { text = '✘' },
      Warn = { text = '▲' },
      Hint = { text = '⚑' },
      Info = { text = '»' },
    },
  })

  -- Configure LSP handlers
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )

  -- LSP capabilities
  local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

  -- LSP attach function
  local function on_attach(client, bufnr)
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = bufnr, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- LSP keybindings
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
    bufmap('v', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', "Code Action")
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', "Show Diagnostic Float")
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', "Go to Previous Diagnostic")
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', "Go to Next Diagnostic")

    -- LSP Debugging keybindings
    bufmap('n', '<leader>li', '<cmd>lua vim.print(vim.lsp.get_clients({bufnr = 0}))<cr>', "LSP Info (Current Buffer)")
    bufmap('n', '<leader>la', '<cmd>lua vim.print(vim.lsp.get_active_clients())<cr>', "LSP Info (All Clients)")
    bufmap('n', '<leader>ll', '<cmd>LspLog<cr>', "LSP Log")
    bufmap('n', '<leader>lc', '<cmd>lua vim.print(vim.lsp.get_clients()[1] and vim.lsp.get_clients()[1].server_capabilities or "No LSP clients")<cr>', "LSP Capabilities")
  end

  -- Setup LSP attach autocmd
  local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = on_attach
  })

  -- Helper function to check if command exists
  local function has_command(cmd)
    return vim.fn.executable(cmd) == 1
  end

  -- Helper function to get mason binary path
  local function get_mason_bin(cmd)
    local home = vim.fn.expand("~")
    return home .. '/.local/share/nvim/mason/bin/' .. cmd
  end

  -- Helper function to check if mason binary exists
  local function has_mason_bin(cmd)
    return vim.fn.filereadable(get_mason_bin(cmd)) == 1
  end

  -- Configure LSP servers only if they're available
  -- TypeScript/JavaScript
  if has_mason_bin('typescript-language-server') or has_command('typescript-language-server') then
    local cmd = has_mason_bin('typescript-language-server') and get_mason_bin('typescript-language-server') or 'typescript-language-server'
    vim.lsp.config('ts_ls', {
      cmd = { cmd, '--stdio' },
      capabilities = lsp_capabilities,
      filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      settings = {
        completions = {
          completeFunctionCalls = true
        }
      }
    })
    vim.lsp.enable({'ts_ls'})
  end

  -- Tailwind CSS
  if has_mason_bin('tailwindcss-language-server') or has_command('tailwindcss-language-server') then
    local cmd = has_mason_bin('tailwindcss-language-server') and get_mason_bin('tailwindcss-language-server') or 'tailwindcss-language-server'
    vim.lsp.config('tailwindcss', {
      cmd = { cmd, '--stdio' },
      capabilities = lsp_capabilities,
      filetypes = { 'html', 'css', 'scss', 'sass', 'less', 'stylus', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
    })
    vim.lsp.enable({'tailwindcss'})
  end

  -- Lua
  if has_mason_bin('lua-language-server') or has_command('lua-language-server') then
    local cmd = has_mason_bin('lua-language-server') and get_mason_bin('lua-language-server') or 'lua-language-server'
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    vim.lsp.config('lua_ls', {
      cmd = { cmd },
      capabilities = lsp_capabilities,
      filetypes = { 'lua' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = runtime_path
          },
          diagnostics = {
            globals = {'vim'}
          },
          workspace = {
            library = {
              vim.fn.expand('$VIMRUNTIME/lua'),
              vim.fn.stdpath('config') .. '/lua'
            },
            checkThirdParty = false
          },
          telemetry = {
            enable = false
          },
        }
      }
    })
    vim.lsp.enable({'lua_ls'})
  end

  -- ESLint
  if has_mason_bin('vscode-eslint-language-server') or has_command('vscode-eslint-language-server') then
    local cmd = has_mason_bin('vscode-eslint-language-server') and get_mason_bin('vscode-eslint-language-server') or 'vscode-eslint-language-server'
    vim.lsp.config('eslint', {
      cmd = { cmd, '--stdio' },
      capabilities = lsp_capabilities,
      filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
    })
    vim.lsp.enable({'eslint'})
  end

  -- HTML
  if has_mason_bin('vscode-html-language-server') or has_command('vscode-html-language-server') then
    local cmd = has_mason_bin('vscode-html-language-server') and get_mason_bin('vscode-html-language-server') or 'vscode-html-language-server'
    vim.lsp.config('html', {
      cmd = { cmd, '--stdio' },
      capabilities = lsp_capabilities,
      filetypes = { 'html' },
    })
    vim.lsp.enable({'html'})
  end

  -- CSS
  if has_mason_bin('vscode-css-language-server') or has_command('vscode-css-language-server') then
    local cmd = has_mason_bin('vscode-css-language-server') and get_mason_bin('vscode-css-language-server') or 'vscode-css-language-server'
    vim.lsp.config('cssls', {
      cmd = { cmd, '--stdio' },
      capabilities = lsp_capabilities,
      filetypes = { 'css', 'scss', 'sass', 'less' },
    })
    vim.lsp.enable({'cssls'})
  end

  -- Ruby
  if has_mason_bin('ruby-lsp') or has_command('ruby-lsp') then
    local cmd = has_mason_bin('ruby-lsp') and get_mason_bin('ruby-lsp') or 'ruby-lsp'
    vim.lsp.config('ruby_lsp', {
      cmd = { cmd },
      capabilities = lsp_capabilities,
      filetypes = { 'ruby' },
    })
    vim.lsp.enable({'ruby_lsp'})
  end
end

-- Create custom LSP log command
vim.api.nvim_create_user_command('LspLog', function()
  local log_file = vim.fn.stdpath('state') .. '/lsp.log'
  if vim.fn.filereadable(log_file) == 1 then
    vim.cmd('split ' .. log_file)
  else
    vim.notify('LSP log file not found: ' .. log_file, vim.log.levels.WARN)
  end
end, { desc = 'Open LSP log file' })

-- Initialize LSP
setup_lsp()
