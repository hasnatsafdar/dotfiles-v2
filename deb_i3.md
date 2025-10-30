## Debian Minimal Setup Script

### 📦 Packages to Install

```bash
sudo apt install -y \
  i3 xorg xinit xrandr ly psmisc build-essential dbus-x11 libnotify-bin rsync stow \
  pipewire pipewire-audio-client-libraries pipewire-pulse \
  fastfetch polybar rofi feh \
  tmux zsh fzf zoxide eza \
  mpv qutebrowser thunar \
  lazygit lazydocker \
  rxvt-unicode xsel lxappearance scrot caffeine \
  git wget curl hsetroot btop \
  ffmpeg 7zip unzip jq poppler-utils fd-find ripgrep imagemagick
```
**Docker**:
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sudo usermod -aG docker $USER

**Flatpak**: 
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
Libre Wolf:
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y

**Chrome**:
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

**Obsidian**:
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.9.14/obsidian_1.9.14_amd64.deb
sudo apt install ./obsidian_1.9.14_amd64.deb

**yazi**:
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt update
sudo apt install yazi

**neovim**
wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim
chmod +x nvim
sudo mv /usr/local/bin
**lazyvim**
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

#### Fonts (JetBrainsMono Nerd)
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv

### ⚙️ Post-Install Configuration

**Enable Display Manager (ly):**

```bash
sudo systemctl enable --now ly
```
systemctl --user enable --now pipewire
systemctl --user enable --now pipewire-pulse

**Set up Zsh with Zinit and Starship (optional):**

```bash
#### Install Zinit
bash -c "$(curl -fsSL https://git.io/zinit-install)"

#### Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

#### Add to ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

**Set i3 as the default session:**

```bash
echo "exec i3" > ~/.xinitrc
```
