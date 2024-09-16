-- https://neovim.io/doc/user/options.html
-- https://neovim.io/doc/user/vim_diff.html#nvim-defaults

local options = {
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  fileencodings = { 'utf-8', 'cp932', 'euc-jp', 'iso-2022-jp' },
  fileformats = { 'unix', 'dos', 'mac' },

  -- tab, indent
  expandtab = true,
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,
  smarttab = true,
  autoindent = true,
  smartindent = true,
  cindent = true,

  -- search
  magic = true,
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  wrapscan = true,
  grepprg = 'internal',

  -- cmd line
  history = 1000,
  wildmenu = true,
  wildmode = { 'list:longest', 'full' },

  -- buffer
  hidden = true,
  autoread = true,

  -- display
  background = 'dark',
  synmaxcol = 300,
  redrawtime = 6000,
  timeoutlen = 600,
  ambiwidth = 'single',
  number = false,
  numberwidth = 4,
  ruler = false,
  showmatch = true,
  showcmd = true,
  showmode = true,
  lazyredraw = true,
  ttyfast = true,
  wrap = true,
  mouse = '',
  title = true,
  conceallevel = 0,
  pumheight = 10,

  -- file
  backup = false,
  writebackup = false,
  swapfile = false,
  undofile = false,
  viminfo="'1000,<500,h,n~/.cache/nvim/.viminfo",

  -- list
  list = true,
  listchars = 'tab:»_,extends:»,precedes:«',

  -- statusline
  cmdheight = 2,
  laststatus = 2,
  statusline = "%<%f %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P",

  -- scroll
  scrolloff = 5,
  sidescrolloff = 8,

  -- help
  helplang = { 'en', 'ja' },

  termguicolors = true,
  winblend = 20,
  pumblend = 20,

  -- https://github.com/vim-jp/issues/issues/152
  -- 最後に改行のないファイルを編集したときに改行を付け加えない
  fixeol = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- input support
vim.opt.clipboard:prepend({'unnamed'})
vim.opt.virtualedit:append({'block'})
vim.opt.formatoptions:append({'m'})
vim.opt.backspace = { 'eol', 'start', 'indent' }
vim.opt.whichwrap = 'b,s,h,l,[,],<,>,~'
vim.opt.startofline = true

-- completion
vim.opt_local.completeopt = { 'menuone', 'noselect' }
vim.opt_local.complete = { 'w', 'b', 'u', 'k', 'i' }

-- foldding
vim.wo.foldmethod = 'marker'

--[[
  termguicolors = true,
  winblend = 0,
  pumblend = 5,
  guifont = 'monospace:h17',

if ( g:is_mac || g:is_unix )
    set termencoding=utf-8
endif
--]]
