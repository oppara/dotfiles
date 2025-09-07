-- tree-sitter によるシンタックスハイライトを行わないファイルタイプ
local disabled_langs = {
  ['sql'] = true,
}

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { 'ipkg' },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if disabled_langs[lang] then
        return true
      end

      -- 100 KB 以上のファイルでは tree-sitter によるシンタックスハイライトを行わない
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = {
  'javascript',
  'typescript.tsx',
}
