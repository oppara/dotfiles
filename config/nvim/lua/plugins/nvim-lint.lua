local lint = require('lint')

local severities = {
  [0] = vim.diagnostic.severity.INFO,
  [1] = vim.diagnostic.severity.WARN,
  [2] = vim.diagnostic.severity.ERROR,
}

lint.linters.textlint = {
  cmd = 'textlint',
  args = {
    '--format',
    'json',
    '--stdin',
    '--stdin-filename',
    function()
      return vim.api.nvim_buf_get_name(0)
    end,
  },
  stdin = true,
  stream = 'stdout',
  ignore_exitcode = true,
  parser = function(output)
    if output == '' then
      return {}
    end
    local decoded = vim.json.decode(output)
    if decoded == nil then
      return {}
    end
    local diagnostics = {}
    for _, value in ipairs(decoded) do
      for _, item in ipairs(value.messages) do
        table.insert(diagnostics, {
          message = item.message,
          col = item.loc.start.column - 1,
          end_col = item.loc['end'].column - 1,
          lnum = item.loc.start.line - 1,
          end_lnum = item.loc['end'].line - 1,
          severity = severities[item.severity],
          source = 'textlint',
        })
      end
    end
    return diagnostics
  end,
}

local stylelint = lint.linters.stylelint
lint.linters.stylelint = {
  cmd = 'npx',
  args = {
    'stylelint',
    '-f',
    'json',
    '--stdin',
    '--stdin-filename',
    function()
      return vim.fn.expand('%:p')
    end,
  },
  stdin = true,
  stream = stylelint.stream,
  ignore_exitcode = stylelint.ignore_exitcode,
  parser = stylelint.parser,
}

local luacheck = lint.linters.luacheck
lint.linters.luacheck = {
  cmd = 'luacheck',
  args = { '--globals', 'vim' },
  stdin = true,
  stream = 'stdout',
  ignore_exitcode = luacheck.ignore_exitcode,
  parser = luacheck.parser,
}

lint.linters_by_ft = {
  lua = { 'luacheck' },
  sh = { 'shellcheck' },
  yaml = { 'yamllint' },
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescriptreact = { 'eslint' },
  json = { 'jsonlint' },
  css = { 'stylelint' },
  scss = { 'stylelint' },
  sass = { 'stylelint' },
  less = { 'stylelint' },
  markdown = { 'markdownlint-cli2', 'textlint' },
  python = { 'ruff', 'flake8' },
  -- brew install sqruff
  sql = { 'sqruff' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '.github/workflows/*.yml',
  callback = function()
    lint.linters_by_ft.yaml = { 'yamllint', 'actionlint' }
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'InsertLeave' }, {
  pattern = { '*.cf.yaml', '*.cf.yml', '*.cfn.yaml', '*.cfn.yml' },
  callback = function()
    lint.linters_by_ft.yaml = { 'yamllint', 'cfn_lint' }
  end,
})
