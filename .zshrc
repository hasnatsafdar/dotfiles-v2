# ╭──────────────────────────────────────────────╮
# │ Zinit Bootstrap (self-installing + portable) │
# ╰──────────────────────────────────────────────╯
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  echo "[zsh] Installing Zinit..." >&2
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  if ! command -v git >/dev/null 2>&1; then
    echo "[zsh] Error: git is not installed. Please install git to use Zinit." >&2
    return 1
  fi
  if ! git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}" >/dev/null 2>&1; then
    echo "[zsh] Error: Failed to clone Zinit repository." >&2
    return 1
  fi
fi
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
else
  echo "[zsh] Error: Zinit not found at ${ZINIT_HOME}/zinit.zsh" >&2
fi

# ╭──────────────────────────────────────────────╮
# │ History and Core Options                      │
# ╰──────────────────────────────────────────────╯
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY INC_APPEND_HISTORY
setopt AUTO_CD EXTENDED_GLOB CORRECT
alias sudo='nocorrect sudo'

# ╭──────────────────────────────────────────────╮
# │ Aliases                                      │
# ╰──────────────────────────────────────────────╯
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=always'
  alias l='eza -lh --icons=always'
  alias la='eza -a --icons=always'
  alias ll='eza -lah --icons=always'
fi
alias c='clear'
alias vim='nvim'
alias pm='sudo pacman -S'
alias pmnc='sudo pacman -S --noconfirm'
alias y='yazi'
if command -v fastfetch >/dev/null 2>&1; then
  if [[ -f /usr/share/fastfetch/presets/examples/10.jsonc ]]; then
    alias ff='fastfetch --logo debian -c /usr/share/fastfetch/presets/examples/10.jsonc'
  else
    alias ff='fastfetch --logo debian'
    echo "[zsh] Warning: fastfetch preset not found, using default config." >&2
  fi
fi

# ╭──────────────────────────────────────────────╮
# │ Vim Keybindings                              │
# ╰──────────────────────────────────────────────╯
bindkey -v
export KEYTIMEOUT=1

# ╭──────────────────────────────────────────────╮
# │ Plugins                                      │
# ╰──────────────────────────────────────────────╯
for plugin in zsh-users/zsh-completions zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting; do
  if ! zinit light "$plugin"; then
    echo "[zsh] Warning: Failed to load plugin $plugin" >&2
  fi
done

# ╭──────────────────────────────────────────────╮
# │ fzf integration                              │
# ╰──────────────────────────────────────────────╯
if command -v fzf >/dev/null 2>&1; then
  # Source default fzf keybindings
  if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  elif [[ -f /usr/local/share/fzf/key-bindings.zsh ]]; then
    source /usr/local/share/fzf/key-bindings.zsh
  fi

  fzf-history-widget() {
    local selected
    selected=$(fc -rl 1 | fzf --height ${FZF_HEIGHT:-40%} --reverse --no-sort +m --query="$LBUFFER" | sed 's/^[0-9 \t]*//') || return 1
    if [[ -n $selected ]]; then
      BUFFER=$selected
      CURSOR=$#BUFFER
      zle redisplay
    fi
  }
  zle -N fzf-history-widget
  bindkey '^R' fzf-history-widget
fi

# ╭──────────────────────────────────────────────╮
# │ Starship Prompt                              │
# ╰──────────────────────────────────────────────╯

eval "$(starship init zsh)"
