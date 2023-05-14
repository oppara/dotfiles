
require('lualine').setup {
  options = {
    theme = 'everforest',
    component_separators = {left = '|', right = '|'},
    section_separators = {},
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {''},
    lualine_b = {'filename', 'diff'},
    lualine_c = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic', 'coc', 'ale'},
        symbols = {error = 'E:', warn = 'W:', info = 'I:', hint = 'H:'},
      }
    },
    lualine_x = {'branch', 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
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
