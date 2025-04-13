local Plugin = {'hrsh7th/nvim-cmp'}

Plugin.dependencies = {
  -- Sources
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'saadparwaiz1/cmp_luasnip'},
  {'hrsh7th/cmp-nvim-lsp'},

  -- Snippets
  {'L3MON4D3/LuaSnip'},
  {'rafamadriz/friendly-snippets'},
}

Plugin.event = 'InsertEnter'

function Plugin.config()
  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')

  require('luasnip.loaders.from_vscode').lazy_load()

	local select_opts = {behavior = cmp.SelectBehavior.Select}
	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
	end

  -- See :help cmp-config
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'copilot', group_index = 2},
      {name = 'buffer', keyword_length = 3},
      {name = 'luasnip', keyword_length = 2},
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    -- formatting = {
    --   fields = {'menu', 'abbr', 'kind'},
    --   format = function(entry, item)
    --     local menu_icon = {
    --       nvim_lsp = 'λ',
    --       luasnip = '⋗',
    --       buffer = 'Ω',
    --       path = '🖫',
    --     }
    --
    --     item.menu = menu_icon[entry.source.name]
    --     return item
    --   end,
    -- },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        max_width = 50,
        symbol_map = { Copilot = "" }
      })
    },
    -- See :help cmp-mapping
    mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
      ['<C-j>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),

      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({select = true}),
      ['<CR>'] = cmp.mapping.confirm({select = false}),

      ['<C-f>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {'i', 's'}),

      ['<C-b>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i', 's'}),

			['<Tab>'] = vim.schedule_wrap(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end),
      -- ['<Tab>'] = cmp.mapping(function(fallback)
      --   local col = vim.fn.col('.') - 1
      --
      --   if cmp.visible() then
      --     cmp.select_next_item(select_opts)
      --   elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      --     fallback()
      --   else
      --     cmp.complete()
      --   end
      -- end, {'i', 's'}),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end, {'i', 's'}),
    },
  })
end

return Plugin
