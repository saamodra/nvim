local Plugin = {'nvim-lualine/lualine.nvim'}

Plugin.event = 'VeryLazy'

-- See :help lualine.txt
Plugin.opts = {
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {'NvimTree'}
    }
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        newfile_status = false,
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[-]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
      }
    },
    lualine_x = {'encoding'},
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        newfile_status = false,
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[-]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
      }
    },
    lualine_x = {'encoding'},
  }
}

function Plugin.init()
  vim.opt.showmode = false
end

return Plugin
