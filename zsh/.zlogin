# increase the keybard repeat rate in sway
export WLC_REPEAT_DELAY=200
export WLC_REPEAT_RATE=40

# exec will replace the current zsh process with sway, so the shell level is
# only 2
exec sway
