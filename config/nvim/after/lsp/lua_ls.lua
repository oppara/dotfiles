return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        ignoreDir = {
          '.git',
          'node_modules',
          '.vscode',
        },
        maxPreload = 1000,
        preloadFileSize = 10000,
      },
      diagnostics = {
        globals = {
          'vim',
          -- 'use',
          -- 'require',
          -- 'pcall',
          -- 'xpcall',
        },
        unusedLocalExclude = { '_*' },
      },
    },
  },
}
