# ZSH OPTIONS
setopt extended_glob
setopt prompt_subst

# KEY BINDINGS
bindkey -v

# ENV VARS
export EDITOR="nvim"
export FPATH="${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/zsh/site-functions:${FPATH}"
export FZF_DEFAULT_OPTS='
	--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
	--color info:254,prompt:37,spinner:108,pointer:235,marker:235
	--inline-info
'
export FZF_CTRL_T_COMMAND="rg --files ${HOME} /etc /usr /var"
export PATH="${HOME}/go/bin:${PATH}"
export PROMPT='%F{cyan}%B%40<..<%3~%b%f$(gitprompt) '
export RPROMPT="%?"
export TMPDIR="/tmp"
export VISUAL="${EDITOR}"
export XKB_DEFAULT_OPTIONS="caps:escape"

# ALIASES
alias ls="ls --color=auto --group-directories-first"

# SOURCES
source "/usr/share/fzf/completion.zsh"
source "/usr/share/fzf/key-bindings.zsh"

# FUNCTIONS
cdl() {
	cd "$1" || exit
	ls
}

qq() {
	clear
	"${HOME}/go/src/github.com/y0ssar1an/q/q.sh"
}

rmqq() {
	if [[ -f "${TMPDIR}/q" ]]; then
		rm "${TMPDIR}/q"
	fi
	qq
}

zle-keymap-select zle-line-init() {
	if [[ "${TERM}" == "linux" ]]; then
		if [[ "${KEYMAP}" == "vicmd" ]]; then
			echo -ne "\e[?2c"					# '\e[?2c' sets cursor to _
		elif [[ "${KEYMAP}" == "main" ]]; then  # main keymap is viins (INSERT mode)
			echo -ne "\e[?6c"					# '\e[?6c' sets cursor to block
		fi
		return
	fi

	if [[ "${KEYMAP}" == "vicmd" ]]; then
		echo -ne "\e[4 q"					# '\e[4 q' sets cursor to _
	elif [[ "${KEYMAP}" == "main" ]]; then  # main keymap is viins (INSERT mode)
		echo -ne "\e[6 q"					# '\e[6 q' sets cursor to |
	fi
}
zle -N zle-keymap-select
zle -N zle-line-init
