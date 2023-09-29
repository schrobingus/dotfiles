## Credit for most of the prompt's code goes to Apeiros (gh: Apeiros-46B).

# Configure the front of the prompt.
PS1='%F{0}%B%(0?.%K{4} .%K{1} )%(1j.$ .)%K{0}%f %~ %k%b '  ## main prompt
PS2='%K{4} %K{0}%B + %b%k '  ## multiline prompt
PS3='%K{4} %K{0}%B select %b%k '  ## select prompt

# Git script for prompt.
gitzsh() {
    if git status 2>&- 1> /dev/null; then
		branch="$(git -P branch | awk '{ print $2 }')"
		if [ "$(git -P diff)" ]; then
	    	 print "%K{0}%B $branch %F{0}%K{5} ± %k%f%b"
		else print "%K{0}%B $branch %F{0}%K{2} %k%f%b"
		fi; exit 0
    else exit 1; fi
}

# Sets the right prompt specifically for the Git script.
precmd() {
    RPROMPT="$(gitzsh)"
}

