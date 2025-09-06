--
-- https://github.com/nvim-lualine/lualine.nvim
--

require('lualine').setup({
  options = {
    theme = 'everforest',
    icons_enabled = false,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str, _)
          local max_len = 7
          return str .. string.rep(' ', max_len - #str)
        end,
      },
    },
  },
  extensions = { 'quickfix' },
})
