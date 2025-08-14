local web_formatter = { 'biome', 'prettier', 'prettierd', stop_after_first = true }

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    php = { 'php_cs_fixer', 'phpcbf', stop_after_first = true },
    sh = { 'shfmt' },
    yaml = { 'yamlfmt' },
    javascript = web_formatter,
    typescript = web_formatter,
    javascriptreact = web_formatter,
    typescriptreact = web_formatter,
    css = web_formatter,
    scss = web_formatter,
    sass = web_formatter,
    less = web_formatter,
    json = { 'prettier_jsonc' },
    jsonc = { 'prettier_jsonc' },
    markdown = { 'markdownlint-cli2' },
    python = { 'ruff_format' },
    sql = { 'sql_formater' },
  },

  formatters = {
    prettier_jsonc = {
      command = 'prettier',
      args = { '--parser', 'json' },
      prepend_args = {
        '--tab-width',
        '2',
        '--use-tabs',
        'false',
      },
      stdin = true,
    },
    php_cs_fixer = {
      command = 'php-cs-fixer',
      prepend_args = { '--using-cache=no', '--config=' .. vim.fn.expand('~/.config/php/php_cs.dist') },
    },
    shfmt = {
      prepend_args = { '-i', '2', '-ci', '-bn', '-s' },
    },
    yamlfmt = {
      command = 'yamlfmt',
      args = { '-' }, -- stdin
      stdin = true,
    },
    -- brew install sql-formatter
    sql_formater = {
      command = 'sql-formatter',
      args = {
        '-c {"tabWidth": 4, "keywordCase": "upper", "dataTypeCase": "upper", "functionCase": "upper", "newlineBeforeSemicolon": true}',
      },
      stdin = true,
    },
  },

  format_on_save = function(bufnr)
    local enabled_filetypes = {
      'sh',
      'lua',
      'yaml',
      'markdown',
      'python',
      'json',
      'jsonc',
    }

    if not vim.tbl_contains(enabled_filetypes, vim.bo[bufnr].filetype) then
      return
    end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match('/node_modules/') then
      return
    end
    -- ...additional logic...
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
})

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

-- TODO: 以下はビジュアルモードで動作しない
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  local opts = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }

  -- ビジュアルモードまたは範囲指定ありの場合
  if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
    opts.range = {
      start = { vim.fn.line('v'), 0 },
      ['end'] = { vim.fn.line('.'), 0 },
    }
  end

  require('conform').format(opts)
end, { desc = 'Format file or range (in visual mode)' })
