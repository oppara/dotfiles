export DOTFILES="${HOME}/dotfiles"

for file in ${DOTFILES}/.{paths,exports,aliases,functions}; do
    test -r "$file" && test -f "$file" && source "$file"
done
unset file

# vim: ft=zsh
