
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/wombat.lua
local colors = {
  base02  = '#444444',
  base3   = '#d0d0d0',
  red     = '#e5786d',
  black   = '#131313',
}

require('lualine').setup {
  options = {
    theme = 'wombat',
    icons_enabled = false,
    component_separators = {left = '|', right = '|'},
    section_separators = {},
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      {
        '%m',
        cond = function()
          return vim.bo.modified
        end,
        component_separators = {},
        color = { fg = colors.base3, bg = colors.base02 },
        padding = 0,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
        component_separators = {},
        color = { fg = colors.red, bg = colors.base02 },
        padding = 0,
      },
      {
        'filename',
        color = { fg = colors.base3, bg = colors.base02 },
        file_status = false,
        newfile_status = true,
        path = 1,
        shorting_target = 40,
      },
      {
        'diff',
        color = { bg = colors.base02 },
      }
    },
    lualine_c = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic', 'coc', 'ale'},
        symbols = {error = 'E:', warn = 'W:', info = 'I:', hint = 'H:'},
      }
    },
    lualine_x = {'branch', 'encoding', 'fileformat', 'filetype'},
    lualine_y = {
      {
        'progress',
        color = { fg = colors.black},
      },
      {
        'location',
        color = { fg = colors.black},
        padding = 0,
      }
    },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        path = 3,
      }
    },
    lualine_x = {'location'},
  },
  extensions = {'quickfix'}
}
