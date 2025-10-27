## Debian Minimal Setup Script

### 📦 Packages to Install

```bash
sudo apt install -y \
  i3 xorg xinit ly \
  fastfetch polybar rofi \
  zsh fzf zoxide eza \
  mpv qutebrowser firefox \
  rxvt-unicode xsel lxappearance scrot \
  git wget curl hsetroot btop
```

### ⚙️ Post-Install Configuration

**Enable Display Manager (ly):**

```bash
sudo systemctl enable --now ly
```

**Set up Zsh with Zinit and Starship (optional):**

```bash
# Install Zinit
bash -c "$(curl -fsSL https://git.io/zinit-install)"

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Add to ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

**Set i3 as the default session:**

```bash
echo "exec i3" > ~/.xinitrc
```
