local Plugin = {'williamboman/mason.nvim'}

Plugin.lazy = false

-- See :help mason-settings
Plugin.opts = {
  ui = {border = 'rounded'}
}

function Plugin.config()
  require('mason').setup(Plugin.opts)
end

return Plugin
