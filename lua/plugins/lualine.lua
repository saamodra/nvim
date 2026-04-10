return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.showmode = false
  end,
  opts = function(_, opts)
    opts.options.globalstatus = false
    opts.options.icons_enabled = true

    local filename = {
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

    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 6 }) }
    opts.sections.lualine_x = { 'encoding' }

    opts.inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = { 'encoding' },
      lualine_y = {},
      lualine_z = {},
    }
  end,
}
