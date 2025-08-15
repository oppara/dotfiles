require('telescope').setup({
  defaults = {
    layout_config = {
      width = 0.75,
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
