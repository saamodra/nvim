local Plugin = {'nvim-treesitter/nvim-treesitter'}

Plugin.dependencies = {
	{'nvim-treesitter/nvim-treesitter-textobjects'},
	{'nvim-treesitter/nvim-treesitter-context'}
}

Plugin.opts = {
	highlight = {
		enable = true,
	},
	indent = {
		enable = true
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			}
		},
	},
	ensure_installed = {
		'javascript',
		'typescript',
		'tsx',
		'ruby',
		'lua',
		'vim',
		'vimdoc',
	  'css',
		'json'
	},
	-- nvim-treesitter-context
	context = {
		enable = true,
    max_lines = 5,
    trim_scope = 'inner',
	}
}

function Plugin.config(opts)
	require('nvim-treesitter.configs').setup(opts)

	require('treesitter-context').setup(opts.context)
end

return Plugin
