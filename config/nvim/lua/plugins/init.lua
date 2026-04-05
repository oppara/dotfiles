-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  { 'vim-jp/vimdoc-ja', ft = 'help' },

  {
    'neanias/everforest-nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('everforest').setup({
        transparent_background_level = 2,
      })
      require('everforest').load()
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('kanagawa').setup({
        transparent = true,
        -- dimInactive = true,
      })
      -- require('kanagawa').load()
    end,
  },
  {
    'oppara/wombat.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    dependencies = { 'rktjmp/lush.nvim' },
  },

  {
    'nvim-tree/nvim-web-devicons',
    cond = function()
      return vim.g.vscode == nil
    end,
    lazy = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('plugins.lualine')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('plugins.indent-blankline')
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    cond = function()
      return vim.g.vscode == nil
    end,
    build = ':TSUpdate',
    branch = 'master',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugins.telescope-nvim')
    end,
  },
  {
    'wsdjeg/mru.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('mru').setup()
      vim.keymap.set('n', 'ffm', function()
        require('telescope').extensions.mru.mru()
      end)
    end,
  },

  {
    'williamboman/mason.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cond = function()
      return vim.g.vscode == nil
    end,
  },
  {
    'b0o/schemastore.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
  },
  {
    'stevearc/conform.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('plugins.conform')
    end,
  },
  {
    'mfussenegger/nvim-lint',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('plugins.nvim-lint')
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    cond = function()
      return vim.g.vscode == nil
    end,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('plugins.copilot')
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    cond = function()
      return vim.g.vscode == nil
    end,
    dependencies = {
      'dcampos/nvim-snippy',
      'dcampos/cmp-snippy',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('plugins.nvim-cmp')
    end,
  },
  {
    'oppara/copilot-cmp',
    branch = 'deprication_fix',
    cond = function()
      return vim.g.vscode == nil
    end,
    dependencies = { 'zbirenbaum/copilot.lua', 'hrsh7th/nvim-cmp' },
    config = function()
      require('copilot_cmp').setup({
        event = { 'InsertEnter', 'LspAttach' },
        fix_pairs = true,
      })
    end,
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   dependencies = {
  --      "zbirenbaum/copilot.lua",
  --      "nvim-lua/plenary.nvim",
  --   },
  --   build = "make tiktoken",
  --   config = function()
  --     require('plugins.copilot-chat')
  --   end
  -- },

  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  {
    'gregorias/coerce.nvim',
    dependencies = {
      'gregorias/coop.nvim',
    },
    config = function()
      require('coerce').setup()
    end,
  },

  {
    'preservim/tagbar',
    cond = function()
      return vim.g.vscode == nil
    end,
    cmd = 'TagbarOpenAutoClose',
    keys = {
      { '<leader>tl', '<cmd>TagbarOpenAutoClose<cr>', silent = true, desc = 'Tagbar open auto close' },
    },
    config = function()
      require('plugins.tagbar')
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('plugins.nvim-tree')
    end,
  },
  {
    'b0o/nvim-tree-preview.lua',
    cond = function()
      return vim.g.vscode == nil
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- {
  --   'mattn/vim-findroot',
  --   config = function()
  --     require('plugins.vim-findroot')
  --   end
  -- },
  --
  -- {
  --   'dense-analysis/ale',
  --   config = function()
  --     require('plugins.ale')
  --   end
  -- },
  --
  -- {
  --   'tpope/vim-fugitive',
  -- },
  --
  {
    'FabijanZulj/blame.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    cmd = { 'BlameToggle' },
    config = function()
      require('blame').setup({
        date_format = '%Y-%m-%d %H:%M',
        max_summary_width = 40,
      })
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {
          line = 'gcc',
          block = 'gbb',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
      })
    end,
  },

  {
    'mattn/emmet-vim',
    ft = { 'html', 'xhtml', 'xml', 'css', 'less', 'sass', 'scss', 'slim', 'haml', 'jade', 'php' },
    init = function()
      require('plugins.emmet')
    end,
  },

  {
    'mattn/vim-sonictemplate',
    cmd = { 'Template' },
    config = function()
      vim.g.sonictemplate_vim_template_dir = '$HOME/.config/nvim/sonictemplate'
    end,
  },

  {
    'thinca/vim-quickrun',
    keys = { { '<leader>r', '<plug>(quickrun)', mode = 'n' } },
    config = function()
      require('plugins.quickrun')
    end,
  },

  {
    'tyru/open-browser.vim',
    keys = { { '<leader>w', '<plug>(openbrowser-smart-search)', mode = 'n' } },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>w', '<plug>(openbrowser-smart-search)', { noremap = false, silent = true })
    end,
  },

  {
    'enoatu/nvim-smartchr',
    event = 'InsertEnter',
    config = function()
      require('plugins.smartchr')
    end,
  },

  {
    'tpope/vim-endwise',
    event = 'InsertEnter',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  --
  -- markdown
  --
  {
    'ixru/nvim-markdown',
    cond = function()
      return vim.g.vscode == nil
    end,
    ft = 'markdown',
    config = function()
      require('plugins.nvim-markdown')
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    ft = { 'markdown', 'plantuml' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.g.mkdp_filetypes = { 'markdown', 'plantuml' }
      require('plugins.markdown-preview')
    end,
  },
  {
    'Kicamon/markdown-table-mode.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    ft = 'markdown',
    config = function()
      require('markdown-table-mode').setup()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
          vim.cmd('Mtm')
        end,
      })
    end,
  },
  {
    'mattn/vim-maketable',
    cond = function()
      return vim.g.vscode == nil
    end,
    ft = 'markdown',
  },

  {
    'aklt/plantuml-syntax',
    ft = { 'markdown', 'plantuml' },
    config = function()
      vim.g.plantuml_set_makeprg = 0
    end,
  },

  {
    'pageer/pdv',
    ft = 'php',
    config = function()
      require('plugins.pdv')
    end,
    dependencies = { 'tobyS/vmustache' },
  },

  {
    'jsborjesson/vim-uppercase-sql',
    ft = 'sql',
  },

  {
    'stevearc/quicker.nvim',
    cond = function()
      return vim.g.vscode == nil
    end,
    config = function()
      require('plugins.quicker')
    end,
  },

  {
    'Jezda1337/nvim-html-css',
    ft = { 'html', 'css' },
    config = function()
      require('plugins.nvim-html-css')
    end,
  },
})
