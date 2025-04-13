local Plugin = { 'akinsho/bufferline.nvim' }

Plugin.event = 'VeryLazy'

Plugin.opts = {
  options = {
    mode = 'buffers',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
      },
    },
  },
  -- :help bufferline-highlights
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = { attribute = 'fg', highlight = 'Function' },
      italic = false
    }
  }
}

return Plugin
