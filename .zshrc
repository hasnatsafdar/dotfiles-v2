# _   _                       _                _
#| | | | __ ___  ___ __   ___| |_      _______| |__  _ __ ___
#| |_| |/ _` \ \/ / '_ \ / _ \ __|    |_  / __| '_ \| '__/ __|
#|  _  | (_| |>  <| | | |  __/ |_    _ / /\__ \ | | | | | (__
#|_| |_|\__,_/_/\_\_| |_|\___|\__|  (_)___|___/_| |_|_|  \___|
#
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Aliases
alias ls='eza --icons=always'
alias l='eza -lh --icons=always'
alias la='eza -a --icons=always'
alias ll='eza -lah --icons=always'
alias c='clear'
alias pm='sudo pacman -S --noconfirm'
alias pr='paru -S --noconfirm'
alias ff='fastfetch | lolcat'

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Just for fun stuff
fortune | cowsay -r | lolcat

