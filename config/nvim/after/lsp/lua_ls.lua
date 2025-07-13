
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
          -- 'use',
          -- 'require',
          -- 'pcall',
          -- 'xpcall',
        },
        unusedLocalExclude = { '_*' }
      }
    }
  }
}
