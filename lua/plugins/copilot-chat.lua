return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- Alternative: zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- For utility functions
    },
    build = "make tiktoken", -- Build command for macOS/Linux
    opts = {
      temperature = 0.1, -- Controls GPT response randomness
      headless = false, -- Use history without writing to chat buffer

      -- Window configuration
      window = {
        layout = 'vertical', -- Options: 'vertical', 'horizontal', 'float', 'replace'
        width = 0.5, -- Fractional or absolute width
        height = 0.5, -- Fractional or absolute height
        relative = 'editor', -- Position relative to 'editor', 'win', 'cursor', or 'mouse'
        border = 'single', -- Window border style
        title = 'Copilot Chat', -- Chat window title
        zindex = 1, -- Window stacking order
      },

      -- Feature toggles
      show_help = true, -- Display help messages
      show_folds = true, -- Enable fold sections in chat
      highlight_selection = true, -- Highlight selected text
      highlight_headers = true, -- Highlight headers in chat
      auto_follow_cursor = true, -- Follow cursor automatically
      auto_insert_mode = false, -- Enter insert mode on new prompt
      insert_at_end = false, -- Move cursor to buffer end on insert
      clear_chat_on_new_prompt = false, -- Clear chat for new prompts

      -- Static configurations
      debug = false, -- Enable debug logging
      log_level = 'info', -- Logging level
      proxy = nil, -- Proxy settings
      allow_insecure = false, -- Allow insecure connections

      chat_autocomplete = true, -- Enable chat autocompletion
      history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- History file path

      -- Headers and separators
      question_header = '# User ',
      answer_header = '# Copilot ',
      error_header = '# Error ',
      separator = '───',

      -- Context providers
      contexts = {
        buffer = {},
        buffers = {},
        file = {},
        files = {},
        git = {},
        url = {},
        register = {},
      },

      prompts = {
        Explain = {
          prompt = '> /COPILOT_EXPLAIN\n\nWrite an explanation for the selected code as paragraphs of text.',
        },
        Review = {
          prompt = '> /COPILOT_REVIEW\n\nReview the selected code.',
          -- see config.lua for implementation
        },
        Fix = {
          prompt = '> /COPILOT_GENERATE\n\nThere is a problem in this code. Rewrite the code to show it with the bug fixed.',
        },
        Optimize = {
          prompt = '> /COPILOT_GENERATE\n\nOptimize the selected code to improve performance and readability.',
        },
        Docs = {
          prompt = '> /COPILOT_GENERATE\n\nPlease add documentation comments to the selected code.',
        },
        Tests = {
          prompt = '> /COPILOT_GENERATE\n\nPlease generate tests for my code.',
        },
        Commit = {
          prompt = '> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        },
      },

      -- Key mappings
      mappings = {
        complete = { insert = '<C-l>' },
        close = { normal = 'q', insert = '<C-c>' },
        reset = { normal = '<C-r>', insert = '<C-r>' },
        submit_prompt = { normal = '<CR>', insert = '<C-s>' },
        toggle_sticky = { normal = 'gr' },
        accept_diff = { normal = '<C-y>', insert = '<C-y>' },
        jump_to_diff = { normal = 'gj' },
        quickfix_diffs = { normal = 'gq' },
        yank_diff = { normal = 'gy', register = '"' },
        show_diff = { normal = 'gd' },
        show_info = { normal = 'gi' },
        show_context = { normal = 'gc' },
        show_help = { normal = 'gh' },
      },
    },
  },
}
