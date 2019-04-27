#!/usr/bin/zsh

setopt extended_glob
setopt prompt_subst

bindkey -v

export BROWSER=firefox
export EDITOR=nvim
export FZF_ALT_C_COMMAND="fd --type directory --hidden '.' ${HOME} /etc /usr /tmp /var"
export FZF_CTRL_T_COMMAND="fd --type file --hidden --exclude .git '.' ${HOME} /etc /usr /tmp /var"
export GDK_BACKEND=wayland
export GOBIN="${HOME}/bin"
export HISTFILE="${HOME}/.histfile"
export HISTSIZE=10000
export PATH="${HOME}/bin:${HOME}/.cargo/bin:${PATH}"
export PROMPT='%F{cyan}%B%40<..<%3~%b%f$(gitprompt) '
export RPROMPT='%?'
export SAVEHIST=10000

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# eval $(keychain --eval --quiet id_ed25519 ~/.ssh/id_ed25519)

alias ll='exa -alh'
alias ls='exa --color=auto --group-directories-first'

cdl() {
	cd $1
	ls
}

cdll() {
	cd $1
	ll
}

qq() {
	clear

	logpath="${TMPDIR}/q"
	if [[ -z "${TMPDIR}" ]]; then
		logpath='/tmp/q'
	fi

	if [[ ! -f "${logpath}" ]]; then
		echo 'Q LOG' > "${logpath}"
	fi

	tail -100f -- "${logpath}"
}

rmqq() {
	logpath="${TMPDIR}/q"
	if [[ -z "${TMPDIR}" ]]; then
		logpath='/tmp/q'
	fi
	if [[ -f "${logpath}" ]]; then
		rm "${logpath}"
	fi
	qq
}

ss() {
	grim -g "$(slurp)" screenshot.jpg
}

zle-keymap-select zle-line-init() {
	if [[ "${KEYMAP}" == 'vicmd' ]]; then
		echo -ne "\e[4 q"
	elif [[ "${KEYMAP}" == 'main' ]]; then
		echo -ne "\e[6 q"
	fi
}

zle -N zle-keymap-select
zle -N zle-line-init

autoload -U compinit
compinit
