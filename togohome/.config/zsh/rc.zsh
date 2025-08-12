
# zmodload zsh/zprof

# Below disables case sensitivity.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

setopt HIST_IGNORE_ALL_DUPS

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

setopt interactive_comments

autoload -U colors && colors

export VIRTUAL_ENV_DISABLE_PROMPT=1

# Credit for most of the prompt to Apeiros.
# (GitHub username: Apeiros-46B).

alias prompt_addins='printf "%s%s" "${IN_NIX_SHELL+❄ }" "${VIRTUAL_ENV+⚙ }"'

prompt_git() {
    if git status 2>&- 1> /dev/null; then
		branch="$(git -P branch | awk '{ print $2 }')"
		if [ "$(git -P diff)" ]; then
	    	 print "%S%B $branch %s%F{0}%K{5} %k%f%b"
		else print "%S%B $branch %s%F{0}%K{2} %k%f%b"
		fi; exit 0
    else exit 1; fi
}

# TODO: fix up the hud icons
precmd() {
    PS1="%F{0}%B%(0?.%K{4} .%K{1} )%(1j.⚑ .)$(prompt_addins)%k%f%S %~ %b%s "  ## Main Prompt
    RPROMPT="$(prompt_git)" ## Git Prompt (Right)
}
PS2='%K{4} %S%B + %b%k%s '  ## Multiline Prompt
PS3='%K{4} %S%B select %b%k%s '  ## Select Prompt

# Credit for transient prompt goes to Roman Perepelitsa.
# (https://www.zsh.org/mla/users/2019/msg00633.html)
zle-line-init() {
  emulate -L zsh
  [[ $CONTEXT == start ]] || return 0
  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done
  # local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  # PROMPT="%F{0}%B%(0?.%K{4} .%K{1} )%b%k "
  RPROMPT=""
  zle .reset-prompt
  # PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt
  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}
zle -N zle-line-init

if [[ -x "nix" ]]; then
  alias nd="nix develop" # NOTE: consider using `nom` if present?
  alias nsh="nix-shell"
  alias ncs="nix-store --gc && sudo nix-store --gc"
  alias ncg="nix-collect-garbage -d && sudo nix-collect-garbage -d"
fi

if [[ -x "nix-channel" ]]; then
  alias ncu="nix-channel --update && sudo nix-channel --update"
  alias ncui="nix-channel --update -vvvvv && sudo nix-channel --update -vvvvv"
fi

if [[ -x "nixos-rebuild-ng" ]]; then
  alias nrs="sudo nixos-rebuild-ng switch"
  alias nrf="sudo nixos-rebuild-ng switch --flake $DOTDIR"
elif [[ -x "nixos-rebuild" ]]; then
  alias nrs="sudo nixos-rebuild switch"
  alias nrf="sudo nixos-rebuild switch --flake $DOTDIR"
fi

if [[ -x "darwin-rebuild" ]]; then
  alias drs="sudo darwin-rebuild switch"
  alias drf="sudo darwin-rebuild switch --flake $DOTDIR"
elif [[ "$(uname)" -eq "Darwin" && -x "nix" ]]; then
  alias drs="echo 'darwin-rebuild binary not found, pulling from github...' && sudo nix run nix-darwin/master#darwin-rebuild -- switch"
  alias drf="echo 'darwin-rebuild binary not found, pulling from github...' && sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake $DOTDIR"
fi

if [[ -x "home-manager" ]]; then
  alias nhs="home-manager switch"
  alias nhf="home-manager switch --flake $DOTDIR"
fi

if [[ -x "$(command -v zoxide)" ]]; then
  eval "$(zoxide init zsh)"
  alias cd=z
fi

if [[ -f "/usr/bin/arch" ]]; then
  alias x86_sh="/usr/bin/arch -x86_64 /bin/zsh"
fi

if [[ -x "doas" && !( -x "sudo" ) ]]; then
  alias sudo="doas"
fi

alias ls="ls -lH --color=auto"
alias x="startx"
alias allah="sudo"

# zprof

