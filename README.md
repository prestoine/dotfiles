# WSL Development Environment Dotfiles

A complete development environment setup for WSL + terminal workflow with automated project management and single-password authentication. This is a pretty specific configuration for my setup, wouldn't recommend cloning it.

## 🚀 What This Provides

### Automated Startup Workflow
- Single password entry for all SSH keys and sudo operations
- Automatic Docker daemon startup
- Interactive project selection menu
- GitHub connectivity checks and DNS resolution

### Smart Project Management
- Organized coding directory structure
- Quick project switching with menu selection
- Separate workspaces for projects, apps, sandbox, and notes

### Development Automation Scripts
- Multi-file inspection utility
- SSL certificate management
- Deployment automation
- Password consolidation for streamlined auth

## 📁 File Structure

```
~/
├── .bashrc                           # Main shell config with startup automation
├── .profile                          # Login shell config
├── .gitconfig                        # Git configuration (customize with your details)
└── coding/
    ├── projects/                     # Main development projects
    ├── apps/                         # Application projects
    ├── sandbox/                      # Experimental/learning projects
    ├── notes/                        # Development notes and documentation
    └── scripts/                      # Automation scripts
        ├── project-selector.sh       # Interactive project menu
        ├── single-password-setup.sh  # SSH/Docker automation
        ├── inspect-files.sh          # Multi-file inspection (`ccat`)
        ├── deploy.sh                 # Deployment automation
        ├── init-certs.sh            # SSL certificate setup
        └── renew-certs.sh           # SSL certificate renewal
```

## 🛠 Prerequisites

- **WSL2** (Debian/Ubuntu recommended)
- **Terminal with tab support** (WezTerm, Windows Terminal, etc.)
- **Git** 
- **Docker** (optional, remove Docker parts if not needed)
- **Node.js and npm** (for development tools)
- **expect** package: `sudo apt install expect`

## 📦 Installation

### 1. Clone and Setup
```bash
# Clone to temporary directory
git clone https://github.com/prestoine/dotfiles.git ~/temp-dotfiles
cd ~/temp-dotfiles

# Backup existing configs
mkdir -p ~/.dotfiles-backup
cp ~/.bashrc ~/.profile ~/.gitconfig ~/.dotfiles-backup/ 2>/dev/null || true
```

### 2. Customize for Your Setup

**Update Git Configuration:**
```bash
# Edit .gitconfig with your details
nano .gitconfig
# Change:
# [user]
#   email = your-email@domain.com  
#   name = Your Name
```

**Customize SSH Key Paths:**
```bash
# Edit single-password-setup.sh
nano coding/scripts/single-password-setup.sh
# Update SSH key paths on lines 13 and 18:
# spawn ssh-add /home/YOUR_USERNAME/.ssh/YOUR_KEY_NAME
```

**Update Directory Paths:**
```bash
# Edit .bashrc if your username isn't 'dfg'
nano .bashrc
# Update any hardcoded paths like /home/dfg/ to /home/YOUR_USERNAME/
```

### 3. Install Files
```bash
# Copy configurations
cp .bashrc ~/.bashrc
cp .profile ~/.profile
cp .gitconfig ~/.gitconfig

# Create directory structure and install scripts
mkdir -p ~/coding/{projects,apps,sandbox,notes,scripts}
cp coding/scripts/* ~/coding/scripts/
chmod +x ~/coding/scripts/*.sh
```

### 4. Configure Your Terminal

**For WezTerm:**
```lua
-- Add to ~/.wezterm.lua or Windows config
return {
  default_prog = {'wsl.exe', '-d', 'YourDistroName'},
  default_cwd = '//wsl$/YourDistroName/home/yourusername',
  -- ... rest of your config
}
```

**For other terminals:** Set starting directory to your home directory in WSL.

### 5. Set Up SSH Keys (Optional)
```bash
# Place your SSH keys in ~/.ssh/
# Ensure they use the same passphrase for single-password workflow
# Update single-password-setup.sh with your key names
```

### 6. Test the Setup
```bash
source ~/.bashrc
# Should automatically navigate to ~/coding/projects/ and run automation
```

## 🎯 Customization Guide

### Modify Startup Behavior
Edit `~/.bashrc` around line 120+:
- Change startup directory
- Add/remove automation steps
- Customize SSH key handling
- Modify Docker startup

### Customize Project Selection
Edit `~/coding/scripts/project-selector.sh`:
- Add custom project directories
- Modify menu options
- Change default behaviors
- Add integrations (tmux, screen, etc.)

### Add Your Own Scripts
Place additional automation scripts in `~/coding/scripts/` and they'll be in your PATH automatically.

### Directory Structure
Organize your projects however you prefer:
```bash
~/coding/
├── work-projects/     # Work-related projects
├── personal/          # Personal projects
├── learning/          # Courses, tutorials, experiments
└── scripts/          # Your automation scripts
```

## 🔧 Configuration Options

### Single Password Setup
- **Enable:** Keep `single-password-setup.sh` as-is
- **Disable:** Remove the call from `.bashrc` and handle SSH keys manually
- **Customize:** Edit the script to add/remove authentication steps

### Project Management
- **Simple:** Just use project selector for navigation
- **Advanced:** Integrate with tmux/screen for session management
- **Custom:** Add your own project templates and initialization

### Docker Integration
- **Keep:** If you use Docker for development
- **Remove:** Delete Docker-related lines from `single-password-setup.sh` and `.bashrc`
- **Customize:** Add your own container startup routines

## 📚 Usage Examples

### Daily Workflow
1. Open terminal → automation runs
2. Enter password once → all services authenticated
3. Select project from menu → start coding
4. Use terminal tabs for additional workspaces

### Key Commands
- `ccat <files>` - Inspect multiple files with headers
- Project selector automatically runs on terminal startup
- All your custom scripts available in PATH

### Adding New Projects
```bash
cd ~/coding/projects
git clone your-new-project
# It will appear in project selector automatically
```

## 🤝 Contributing

This is designed to be a template/starting point. Fork it and customize for your workflow!

**Ideas for enhancement:**
- tmux/screen integration
- IDE/editor selection menu  
- Cloud service authentication
- Development environment templates
- Database connection management

## 🐛 Troubleshooting

### Permission Issues
```bash
chmod +x ~/coding/scripts/*.sh
chmod 600 ~/.ssh/* 2>/dev/null || true
```

### Path Issues
Update any hardcoded paths in:
- `.bashrc` (startup automation)
- `coding/scripts/single-password-setup.sh` (SSH key paths)
- Terminal configuration (starting directory)

### SSH Key Problems
- Ensure keys exist in `~/.ssh/`
- Verify same passphrase for all keys
- Update key names in `single-password-setup.sh`

---

**🎯 Goal:** Streamlined development environment with minimal daily friction and maximum automation.

**🔄 Philosophy:** One password, smart defaults, easy customization, and quick project switching.
