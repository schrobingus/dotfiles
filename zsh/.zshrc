# Source every stage.
## source ~/.config/zsh/stages/*.zsh
for file in ~/.config/zsh/stages/*.zsh; do
    source "$file"
done
