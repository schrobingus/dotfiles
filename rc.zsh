# Below disables case sensitivity.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

setopt interactive_comments

autoload -U colors && colors

export VIRTUAL_ENV_DISABLE_PROMPT=1

# Credit for most of the prompt to Apeiros (gh: Apeiros-46B).
alias prompt_addins='printf "%s%s" "${IN_NIX_SHELL+❄ }" "${VIRTUAL_ENV+⚙ }"'
prompt_git() {
    if git status 2>&- 1> /dev/null; then
		branch="$(git -P branch | awk '{ print $2 }')"
		if [ "$(git -P diff)" ]; then
	    	 print "%K{0}%B $branch %F{0}%K{5} %k%f%b"
		else print "%K{0}%B $branch %F{0}%K{2} %k%f%b"
		fi; exit 0
    else exit 1; fi
}
precmd() {
    PS1="%F{0}%B%(0?.%K{4} .%K{1} )%(1j.⚑ .)$(prompt_addins)%K{0}%f %~ %k%b "  ## Main Prompt
    RPROMPT="$(prompt_git)" ## Git Prompt (Right)
}
PS2='%K{4} %K{0}%B + %b%k '  ## Multiline Prompt
PS3='%K{4} %K{0}%B select %b%k '  ## Select Prompt

export PATH=/opt/podman/bin:$PATH

alias ls="ls -lH --color=auto"
