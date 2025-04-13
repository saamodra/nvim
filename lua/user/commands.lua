local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.slim",
  command = "setlocal filetype=slim"
})

function StripTrailingWhitespaces()
  local _s = vim.fn.getreg('/')
  local l = vim.fn.line('.')
  local c = vim.fn.col('.')

  vim.cmd('%s/\\s\\+$//e')
  vim.fn.setreg('/', _s)
  vim.fn.cursor(l, c)
end

vim.api.nvim_create_user_command('StripTrailingWhitespaces', StripTrailingWhitespaces, {})

function CopyRelativeFilePath()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('+', filepath)
  print("Relative file path copied to clipboard: " .. filepath)
end

vim.api.nvim_create_user_command('CopyRelativeFilePath', CopyRelativeFilePath, {})

function GetYamlPath()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()

  if not node then
    print("No node found")
    return
  end

  local path = {}
  while node do
    if node:type() == "block_mapping_pair" then
      table.insert(path, 1, vim.treesitter.get_node_text(node:child(0), 0))
    end
    node = node:parent()
  end

  local yaml_path = table.concat(path, ".")
  vim.fn.setreg("+", yaml_path)
  print("Copied YAML path: " .. yaml_path)
end

vim.api.nvim_create_user_command('GetYamlPath', GetYamlPath, {})


function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

