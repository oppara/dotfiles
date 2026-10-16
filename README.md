# My Dotfiles

    % ./setup.sh

## Nix (home-manager)

パッケージは `dot.config/home-manager/` で管理する（`setup.sh` で `~/.config/home-manager` にリンクされる）。

### 初回

    % nix run home-manager/master -- switch

### パッケージの追加・削除

`dot.config/home-manager/home.nix` の `home.packages` を編集して反映する。

    % home-manager switch

新規ファイルは `git add` しないと flake から見えない。

### Homebrew からの移行

`home.packages` に追加して反映し、Nix 版が使われていることを確認してから削除する。

    % home-manager switch
    % which <command>
    % brew uninstall <formula>

### 更新

    % nix flake update --flake ~/.config/home-manager
    % home-manager switch

更新後は `flake.lock` をコミットする。

### 確認・ロールバック

    % home-manager packages
    % home-manager generations
    % home-manager switch --rollback

### 掃除

    % home-manager expire-generations "-30 days"
    % nix store gc

