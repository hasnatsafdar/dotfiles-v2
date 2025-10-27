#!/bin/bash
# =====================================================
# Git + SSH Setup Script
# For developers who sync SSH keys via Bitwarden
# =====================================================

# --- Basic System Setup ---
echo "🔄 Updating system..."
sudo apt update -y

# --- Install Git ---
echo "📦 Installing Git..."
sudo apt install -y git

# --- Configure Git User ---
echo "🧑‍💻 Configuring Git user..."
read -p "Enter your Git user name: " git_name
read -p "Enter your Git email: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "✅ Git configured:"
git config --list | grep user

# --- Setup SSH Directory ---
echo "🔐 Setting up SSH keys..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# --- Paste SSH Key ---
echo "Paste your PRIVATE SSH key below (end with Ctrl+D):"
cat > ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519

echo "Paste your PUBLIC SSH key below (end with Ctrl+D):"
cat > ~/.ssh/id_ed25519.pub
chmod 644 ~/.ssh/id_ed25519.pub

# --- Start SSH Agent ---
echo "⚙️ Starting SSH agent..."
eval "$(ssh-agent -s)"

# --- Add Key to Agent ---
ssh-add ~/.ssh/id_ed25519

# --- Test GitHub SSH Connection ---
echo "🔎 Testing SSH connection to GitHub..."
ssh -T git@github.com

echo "🎉 Setup complete! Git + SSH are ready to use."

