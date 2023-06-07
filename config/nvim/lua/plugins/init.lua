-- https://github.com/tani/vim-jetpack
-- https://zenn.dev/dog/articles/jetpack_intro

local jetpackfile = vim.fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
  vim.fn.system(string.format('curl -fsSLo %s --create-dirs %s', jetpackfile, jetpackurl))
end


vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
  {
    'tani/vim-jetpack',
    opt = 1
  }, -- bootstrap

  'rebelot/kanagawa.nvim',
  {
    'oppara/wombat.nvim',
    requires = 'rktjmp/lush.nvim'
  },

  {
    'nvim-tree/nvim-web-devicons',
    opt = 1
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end
  },

  'vim-jp/vimdoc-ja',

  {
    'junegunn/fzf.vim',
    config = function()
      vim.api.nvim_set_keymap('n', 'ffh', ':History<CR>', {noremap = true, silent = true})
    end
  },
  {
    'junegunn/fzf',
    run = './install'
  },

  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      require('plugins.coc')
    end
  },

  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end
  },

  {
    'preservim/tagbar',
    config = function()
      require('plugins.tagbar')
    end
  },

  {
    'dense-analysis/ale',
    config = function()
      require('plugins.ale')
    end
  },

  {'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
          toggler = {
            line = '<leader>cc',
            block = '<leader>bc',
          },
          opleader = {
            line = '<leader>cc',
            block = '<leader>bc',
          },
          extra = {
            above = '<leader>cO',
            below = '<leader>co',
            eol = '<leader>cA',
          },
        })
    end
  },

  {
    'mattn/emmet-vim',
    ft = {'html', 'xhtml', 'xml', 'css', 'less', 'sass', 'scss', 'slim', 'haml', 'jade', 'php'},
    setup = function()
      require('plugins.emmet')
    end
  },

  {
    'mattn/vim-sonictemplate',
    config = function()
      vim.g.sonictemplate_vim_template_dir = '$HOME/.config/nvim/sonictemplate'
    end
  },

  {
    'thinca/vim-quickrun',
    config = function()
      require('plugins.quickrun')
    end
  },

  {
    'tyru/open-browser.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>w', '<plug>(openbrowser-smart-search)', {noremap = false, silent = true})
    end
  },

  {
    'kana/vim-smartchr',
    config = function()
      vim.cmd[[inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')]]
    end
  },
  {
    'sheerun/vim-polyglot',
    config = function()
      require('plugins.polyglot')
    end
  },

  {
    'tpope/vim-endwise',
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  },

  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = function() vim.fn['mkdp#util#install']() end,
    config = function()
      require('plugins.markdown-preview')
    end
  },

  {
    'pageer/pdv',
    ft = 'php',
    config = function()
      require('plugins.pdv')
    end,
    requires = 'tobyS/vmustache'
  },

  {
    'z0mbix/vim-shfmt',
    ft = 'sh',
    config = function()
      require('plugins.shfmt')
    end,
  },

  'jsborjesson/vim-uppercase-sql',
}

--[[

  -- 'https://github.com/dense-analysis/ale',
  -- {'dracula/vim', as = 'dracula' },
  Plug 'itchyny/lightline.vim'

  Plug 'mattn/vim-molder'
  Plug 'mattn/vim-molder-operations'

  "Plug 'Shougo/context_filetype.vim'

  "Plug 'LeafCage/yankround.vim'
  Plug 'thinca/vim-localrc'
  "Plug 'thinca/vim-qfreplace'
  "Plug 'fuenor/qfixgrep'
  "Plug 'anyakichi/vim-qfutil'

  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-endwise', {'for': ['ruby']}

  Plug 'rhysd/git-messenger.vim'

  "" Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'vim-scripts/sudo.vim'

  Plug 'Valloric/MatchTagAlways'

  Plug 'Yggdroot/indentLine'
  "" Plug 'rhysd/migemo-search.vim'
  "" if executable('cmigemo')
    "" cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
  "" endif

  "Plug 'kana/vim-fakeclip', {'on':  ['<Plug>(fakeclip-']}


  "Plug 'kana/vim-textobj-user'
  "Plug 'kana/vim-textobj-jabraces', {'on': ['TextobjJabracesDefaultKeyMappings']}
  "Plug 'kana/vim-textobj-fold', {'on': ['TextobjFoldDefaultKeyMappings']}
  "Plug 'anyakichi/vim-textobj-ifdef', {'on': ['TextobjIfdefDefaultKeyMappings']}
  "Plug 'akiyan/vim-textobj-php', {'for': ['php']}
  "Plug 'bps/vim-textobj-python', {'for': ['python']}
  "Plug 'rhysd/vim-textobj-ruby', {'for': ['ruby']}
  "Plug 'akiyan/vim-textobj-xml-attribute', {'for': ['xml']}

  Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign']}

  Plug 'vim-test/vim-test'



"" " http://www.karakaram.com/vim/phpunit-location-list/
  Plug 'oppara/vim-quickrun-phpunit', { 'branch': 'fix-color', 'for': ['php']}
  "Plug 'vim-scripts/phpfolding.vim', {'for': ['php']}
  Plug 'oppara/php.vim', {'for': ['php']}
  Plug 'jwalton512/vim-blade', {'for': ['php']}

  Plug 'oppara/sql_iabbr.vim', {'for': ['sql']}
  Plug 'mattn/vim-sqlfmt', {'on': 'SQLFmt'}

  Plug 'kannokanno/previm', {'for': ['markdown']}
  Plug 'rhysd/vim-gfm-syntax'
  Plug 'mattn/vim-maketable'

  Plug 'hail2u/vim-css3-syntax', {'for': ['css']}

  Plug 'elzr/vim-json'
  Plug 'kevinoid/vim-jsonc'
  "Plug 'heavenshell/vim-jsdoc', {
        "\ 'for': ['javascript', 'javascript.jsx','typescript'],
        "\ 'do': 'make install'
        "\}

  Plug 'hashivim/vim-terraform'

  Plug 'luochen1990/rainbow'
  Plug 'simeji/winresizer'


]]




