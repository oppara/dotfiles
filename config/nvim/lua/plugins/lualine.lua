--
-- https://github.com/nvim-lualine/lualine.nvim
--
--

local function file_symbols()
  if vim.bo.readonly then
    return 'RO'
  elseif vim.bo.modified then
    return '+'
  elseif vim.fn.bufname() == '' then
    return 'No Name'
  elseif vim.bo.buftype == '' and vim.fn.filereadable(vim.fn.expand('%:p')) == 0 then
    return 'New'
  else
    return ''
  end
end

require('lualine').setup({
  options = {
    theme = 'everforest',
    icons_enabled = false,
  },
  sections = {
    lualine_a = {
      {
        file_symbols,
      },
      {
        'mode',
        fmt = function(str, _)
          local max_len = 7
          return str .. string.rep(' ', max_len - #str)
        end,
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = false,
      },
    },
  },
  extensions = {
    'nvim-tree',
    'quickfix',
  },
})
