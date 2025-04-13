local Plugin = {'williamboman/mason.nvim'}

Plugin.lazy = false

-- See :help mason-settings
Plugin.opts = {
  ui = {border = 'rounded'},
	ensure_installed = {
		'eslint-lsp',
		'typescript-language-server',
	}
}

return Plugin

