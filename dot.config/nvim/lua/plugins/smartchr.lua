require('nvim-smartchr').setup({
  mappings = {
    default = {
      { '<', { '<', '>' } },
    },
    ['perl|php||ruby'] = {
      { '>', { '>', '->', '=>', '>>' }, { loop = true } },
    },
    ['javascript|typescript'] = {
      { '>', { '>', '=>', '>>' }, { loop = true } },
    },
  },
})
