require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    sorting_strategy = 'ascending',
    previewer = true,
    layout_config = {
      prompt_position = 'top',
      preview_cutoff = 1,
    },
    file_ignore_patterns = {
      '%.git/',
      '%vendor',
      '%venv',
      '%node_modules',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'fff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', 'ffg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', 'ffb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', 'ffo', builtin.oldfiles, { desc = 'Telescope oldfiles' })

vim.keymap.set('n', 'gd', builtin.lsp_definitions)
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions)
vim.keymap.set('n', 'gi', builtin.lsp_implementations)
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references({
    show_line = false,
    include_declaration = false,
  })
end)
