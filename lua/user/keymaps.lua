local map = require('utils.map').map

-- Space as leader key
vim.g.mapleader = ' '

-- Basic clipboard interaction
map({'n', 'x'}, 'gy', '"+y', "Copy to clipboard")
map({'n', 'x'}, 'gp', '"+p', "Paste from clipboard")

-- Commands
map('n', '<leader>bq', '<cmd>bdelete<cr>', "Close current buffer")
map('n', '<leader>bl', '<cmd>buffer #<cr>', "Switch to last buffer")
map("t", "<C-o>", "<C-\\><C-n>", "Exit Terminal Mode")

-- Window navigation
map('n', '<C-J>', '<C-W>j', "Move to window below")
map('n', '<C-K>', '<C-W>k', "Move to window above")
map('n', '<C-H>', '<C-W>h', "Move to window left")
map('n', '<C-L>', '<C-W>l', "Move to window right")

-- Custom commands
map('n', '<leader>cw', '<cmd>lua StripTrailingWhitespaces()<cr>', "Strip trailing whitespaces")
map('n', '<leader>cn', '<cmd>cnext<cr>', "Quickfix Next")
map('n', '<leader>cp', '<cmd>cprev<cr>', "Quickfix Previous")
map('n', '<leader>ct', '<cmd>TailwindSort<cr>', "Tailwind Sort")
map('v', '<leader>ct', '<cmd>TailwindSortSelection<cr>', "Tailwind Sort Selection")

map('n', '<leader>yr', '<cmd>lua CopyRelativeFilePath()<cr>', "Copy relative file path")
map('n', '<leader>yp', '<cmd>lua GetYamlPath()<cr>', "Copy YAML path")


-- Git keymaps
map('n', '<leader>gs', '<cmd>Git<cr>', "Git status")
map('n', '<leader>gd', '<cmd>Gdiffsplit<cr>', "Git diff")
map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', "Git branch")
map('n', '<leader>gr', '<cmd>Gread<cr>', "Git read (checkout file)")
map('n', '<leader>gw', '<cmd>Gwrite<cr>', "Git write (stage file)")
map('n', '<leader>ge', '<cmd>Gedit<cr>', "Git edit (open file in index)")
map('n', '<leader>gc', '<cmd>CopilotChat<cr>', "GitHub Copilot Chat")

-- Neotest keymaps
map('n', '<leader>tf', '<cmd>TestNearest<cr>', "Run Test Vim-Test")
map('n', '<leader>tr', ':lua require("neotest").run.run()<CR>', "Run Test")
map('n', '<leader>tc', ':lua require("neotest").run.stop()<CR>', "Stop Test")
map('n', '<leader>tt', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Run Tests on Current File")
map('n', '<leader>ta', ':lua require("neotest").run.attach()<CR>', "Attach to Test")
map('n', '<leader>ts', ':lua require("neotest").summary.toggle()<CR>', "Toggle Test Summary")
map('n', '<leader>to', ':lua require("neotest").output_panel.toggle()<CR>', "Toggle Test Output")

