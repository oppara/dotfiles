# My Dotfiles

    % ./setup.sh

## [Vim](https://github.com/vim-jp/vim)

    % brew install vim --with-lua --with-luajit 

or

    % hg clone https://vim.googlecode.com/hg/ vim
    % cd vim
    % hg pull -u
    % cd src
    % ./configure --prefix=${HOME}/bin \
      --with-features=huge \
      --enable-multibyte \
      --enable-xim \
      --enable-fontset \
      --disable-selinux \
      --disable-gui \
      --with-tlib=ncurses \
      --enable-rubyinterp \
      --enable-luainterp \
      --without-x

    % make && make install


### [NeoBundle](https://github.com/Shougo/neobundle)

    % mkdir ~/.vim/bundle
    % cd ~/.vim/bundle/
    % git clone  https://github.com/Shougo/neobundle.vim.git


### [MacVim](https://code.google.com/p/macvim-kaoriya/)

    % brew cask install oppara/homebrew/macvim-kaoriya
