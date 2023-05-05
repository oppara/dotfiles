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
    'ViViDboarder/wombat.nvim',
    requires = 'rktjmp/lush.nvim'
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
    'dense-analysis/ale',
    config = function()
      require('plugins.ale')
    end
  },

  {'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        highlight = {
          enable = true,
          -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1742#issuecomment-903878861
          additional_vim_regex_highlighting = true,
        }
      }
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
    'mattn/vim-sonictemplate',
    config = function()
      vim.g.sonictemplate_vim_template_dir = '$HOME/.vim/sonictemplate'
    end
  },

  {
    'thinca/vim-quickrun',
    cmd = 'QuickRun',
    keys = '<Plug>(quickrun'
  },

  'kana/vim-smartchr',
  {
    'sheerun/vim-polyglot',
    config = function()
      require('plugins.polyglot')
    end
  },

  {
    'tobyS/pdv',
    ft = 'php'
  },
}

--[[

  -- 'https://github.com/dense-analysis/ale',
  -- {'dracula/vim', as = 'dracula' },
  Plug 'itchyny/lightline.vim'

  Plug 'mattn/vim-molder'
  Plug 'mattn/vim-molder-operations'

  "Plug 'Shougo/context_filetype.vim'

  Plug 'majutsushi/tagbar'

  "Plug 'LeafCage/yankround.vim'
  Plug 'thinca/vim-localrc'
  "Plug 'thinca/vim-qfreplace'
  "Plug 'fuenor/qfixgrep'
  "Plug 'anyakichi/vim-qfutil'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-repeat'
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


  Plug 'mattn/emmet-vim', {'for': ['html', 'xhtml', 'xml', 'css', 'less', 'sass', 'scss', 'slim', 'haml', 'jade', 'php']}

  Plug 'jiangmiao/auto-pairs'
  Plug 'alvan/vim-closetag'

  "Plug 'kana/vim-fakeclip', {'on':  ['<Plug>(fakeclip-']}
  Plug 'kana/vim-smartchr'


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

  Plug 'tyru/open-browser.vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'w0rp/ale'

  " shell
  Plug 'z0mbix/vim-shfmt', { 'for': 'sh'  }

  Plug 'tobyS/vmustache'
  Plug 'tobyS/pdv', {'for': ['php']}

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




