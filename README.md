# Development Environment Dotfiles

Personal dotfiles and development environment setup for WSL + WezTerm workflow.

## What's Included

### Shell Configuration
- **`.bashrc`** - Main shell configuration with automated startup workflow
- **`.profile`** - Login shell configuration  
- **`.gitconfig`** - Git configuration

### Development Scripts (`coding/scripts/`)
- **`project-selector.sh`** - Interactive project selection menu
- **`single-password-setup.sh`** - Automated SSH key and Docker setup with single password entry
- **`inspect-files.sh`** - Multi-file inspection utility (`ccat` command)
- **`deploy.sh`** - Production deployment script
- **`init-certs.sh`** - SSL certificate initialization
- **`renew-certs.sh`** - SSL certificate renewal

## File Structure

```
~/
├── .bashrc                           # Main shell config
├── .profile                          # Login shell config
├── .gitconfig                        # Git configuration
└── coding/
    └── scripts/                      # Development automation scripts
        ├── project-selector.sh       # Project selection menu
        ├── single-password-setup.sh  # SSH/Docker automation
        ├── inspect-files.sh          # File inspection utility
        ├── deploy.sh                 # Deployment script
        ├── init-certs.sh            # SSL cert initialization
        └── renew-certs.sh           # SSL cert renewal
```

## Prerequisites

- **WSL2** (Debian/Ubuntu)
- **WezTerm** terminal
- **Git** 
- **Docker** 
- **Node.js and npm** (for development tools)
- **SSH keys** set up for GitHub/servers

## Installation

### 1. Clone this repository
```bash
git clone git@github.com:prestoine/dotfiles.git ~/temp-dotfiles
cd ~/temp-dotfiles
```

### 2. Backup existing configs
```bash
mkdir -p ~/.dotfiles-backup
cp ~/.bashrc ~/.dotfiles-backup/ 2>/dev/null || true
cp ~/.profile ~/.dotfiles-backup/ 2>/dev/null || true
cp ~/.gitconfig ~/.dotfiles-backup/ 2>/dev/null || true
```

### 3. Install dotfiles
```bash
# Copy shell configurations
cp .bashrc ~/.bashrc
cp .profile ~/.profile  
cp .gitconfig ~/.gitconfig

# Create coding directory structure and install scripts
mkdir -p ~/coding/scripts
cp -r coding/scripts/* ~/coding/scripts/
chmod +x ~/coding/scripts/*.sh
```

### 4. Configure WezTerm
Update your WezTerm config (`~/.wezterm.lua` or `C:\Users\username\.wezterm.lua`) to start in your home directory:

```lua
return {
  default_prog = {'wsl.exe', '-d', 'Debian'},
  default_cwd = '//wsl$/Debian/home/prestoine',  -- Replace with your username
  -- ... rest of your config
}
```

### 5. Set up SSH keys
Ensure your SSH keys are in place:
```bash
# Your keys should be at:
# ~/.ssh/linode  
# ~/.ssh/github
# 
# Make sure they use the same passphrase for automated setup
```

### 6. Reload configuration
```bash
source ~/.bashrc
```

## Features

### Automated Startup Workflow
When you open a new terminal, the system automatically:
1. Navigates to `~/coding/projects/`
2. Starts SSH agent and adds keys (single password prompt)
3. Checks GitHub connectivity and adds to hosts if needed
4. Starts Docker daemon
5. Presents interactive project selection menu

### Project Selection Menu  
Choose from:
- Individual projects in `~/coding/projects/`
- Notes directory (`~/coding/notes/`)
- Plain terminal

### Single Password Authentication
All SSH keys and sudo operations use the same password for streamlined authentication.

### Development Scripts
- **`ccat`** - Enhanced file inspection (alias for `inspect-files.sh`)
- Project-specific deployment and SSL management scripts

## Directory Organization

Your coding directory should be organized as:
```
~/coding/
├── projects/          # Main development projects
├── apps/              # Application projects  
├── sandbox/           # Experimental/learning projects
├── notes/             # Development notes and documentation
└── scripts/           # Automation scripts (tracked in this repo)
```

## Related Repositories

- [nvim](https://github.com/prestoine/nvim) - Neovim configuration (separate repo)

## Usage

### Daily Workflow
1. Open WezTerm - automation runs, prompts for password once
2. Select project from menu
3. Neovim opens in project directory
4. Use `<Space>tt` in WezTerm to create additional terminal tabs
5. Use `<Space>w1`, `<Space>w2`, `<Space>w3` to switch between tabs

### Key Commands
- `ccat <files>` - Inspect multiple files with headers
- `<Space>tt` - Create new terminal tab (WezTerm)
- `<Space>w[1-9]` - Switch between terminal tabs

## Customization

Edit `~/.bashrc` to modify:
- Startup automation behavior
- Directory paths
- SSH key locations
- Docker startup options

Edit `~/coding/scripts/project-selector.sh` to customize:
- Project directory structure
- Menu options
- Default behaviors

## Troubleshooting

### "Command not found" errors
Ensure scripts are executable:
```bash
chmod +x ~/coding/scripts/*.sh
```

### SSH key issues
Verify keys exist and have correct permissions:
```bash
ls -la ~/.ssh/
chmod 600 ~/.ssh/linode ~/.ssh/github
```

### WezTerm tab creation
If `<Space>tt` doesn't work, check your WezTerm key bindings configuration.

---

**Note**: This dotfiles setup is optimized for WSL2 + WezTerm + Docker development workflow. Adjust paths and configurations as needed for your specific setup.
