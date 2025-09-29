# Neovim Configuration

<a href="https://dotfyle.com/saamodra/nvim"><img src="https://dotfyle.com/saamodra/nvim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/saamodra/nvim"><img src="https://dotfyle.com/saamodra/nvim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/saamodra/nvim"><img src="https://dotfyle.com/saamodra/nvim/badges/plugin-manager?style=for-the-badge" /></a>

This guide will help you install and set up my Neovim configuration.

## 📥 Installation

### 1. Prerequisites
Ensure you have the following dependencies installed:

- **Neovim** (>= 0.9)
- **Git**
- **Python3 & pip**
- **Node.js & npm**
- **Ripgrep** (for Telescope fuzzy finding)

### 2. Clone the Configuration
Backup existing Neovim configuration (if any):
```sh
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone this repository:
```sh
git clone https://github.com/saamodra/nvim.git
cp -r nvim ~/.config/nvim
```

### 3. Install Plugins
Launch Neovim and run:
```sh
nvim
```
Then install plugins with:
```
:Lazy sync
```

### 4. Verify Installation
Ensure everything is working by checking:
- `:checkhealth` inside Neovim
- Plugins are installed correctly
- Keybindings and settings are applied
