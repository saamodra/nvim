local Plugin = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "jonarrien/telescope-cmdline.nvim" },
  },
  cmd = { "Telescope" },
}

local map = require("utils.map").map

function Plugin.init()
  map("n", "<C-P>", "<cmd>Telescope find_files<cr>", "Find Files (Ctrl+P)")
  map("n", "<C-F>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in Buffer")
  map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Open Buffers")
  map("n", "<leader>fc", "<cmd>Telescope cmdline<cr>", "Cmdline")
  map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", "Diagnostics")
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Find Files")
  map("n", "<leader>fg", "<cmd>Telescope live_grep_args<cr>", "Live Grep")
  map("n", "<leader>fm", "<cmd>Telescope bookmarks list<cr>", "Bookmarks")
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", "Recently Opened Files")
  map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", "Quickfix List")
  map("n", "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>", "Quickfix History")
  map("n", "<leader>fs", "<cmd>Telescope git_status<cr>", "Git Status")
  map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", "Todo Comments")
end

function MultiMove(action, count)
  return function(prompt_bufnr)
    for _ = 1, count do
      action(prompt_bufnr)
    end
  end
end

function Plugin.config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local lga_actions = require("telescope-live-grep-args.actions")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-u>"] = MultiMove(actions.move_selection_previous, 4),
          ["<C-d>"] = MultiMove(actions.move_selection_next, 4),
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
        },
      },
    },
    pickers = {
      git_branches = {
        previewer = false
      }
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-o>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
          },
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown { }
      }
    }
  })

  telescope.load_extension('bookmarks')
  telescope.load_extension('fzf')
  telescope.load_extension('live_grep_args')
  telescope.load_extension('ui-select')
  telescope.load_extension('cmdline')
end

return Plugin
