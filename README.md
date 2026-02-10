# Neovim Configuration

A modern, feature-rich Neovim configuration focused on development efficiency and workflow optimization.

[中文文档](./README_CN.md)

## Features

### Core Capabilities

- **LSP Support**: Full Language Server Protocol integration with auto-completion, diagnostics, and code actions
- **Smart Completion**: Powered by blink.cmp with Copilot integration and buffer words suggestions
- **Syntax Highlighting**: Advanced syntax highlighting via nvim-treesitter
- **File Navigation**: Fuzzy finding with Telescope and hierarchical file explorer with Neo-tree
- **Git Integration**: Comprehensive git workflows with lazygit, gitsigns, diffview, and conflict resolution
- **Debugging**: Full DAP (Debug Adapter Protocol) support with UI
- **Session Management**: Automatic session persistence and restoration
- **Terminal Integration**: Integrated terminal with toggleterm

### Language Support

- **Python**: Enhanced support with venv-selector, DAP debugging
- **Go**: Comprehensive Go development with go.nvim
- **Rust**: Full Rust support via rustaceanvim
- **Java**: Spring Boot and general Java development
- **Haskell**: Specialized Haskell tooling
- **Web Development**: HTML, CSS, JavaScript/TypeScript with auto-tag completion
- **Database**: SQL editing and database management with nvim-dbee
- **HTTP Testing**: API testing with kulala.nvim
- **Markdown**: Enhanced markdown rendering and editing

### UI/UX Enhancements

- **Color Scheme**: Kanagawa theme
- **Status Line**: Feature-rich lualine with LSP progress
- **Buffer Line**: Elegant buffer management with bufferline
- **Dashboard**: Custom startup screen
- **Which-key**: Interactive keybinding help
- **Code Outline**: Symbol navigation with aerial.nvim
- **Smooth Scrolling**: Enhanced scrolling experience with neoscroll
- **Indent Guides**: Visual indent indicators
- **Winbar/Dropbar**: Contextual breadcrumbs navigation

### Productivity Tools

- **Flash**: Lightning-fast cursor movement
- **Grug-far**: Advanced search and replace
- **Comment**: Smart commenting utilities
- **Autopairs**: Automatic bracket pairing
- **Todo Comments**: Highlight and manage TODO/FIXME/NOTE comments
- **Undotree**: Visual undo history
- **Word Counter**: Track document statistics
- **Live Rename**: Real-time LSP rename preview
- **Fcitx Integration**: Automatic input method switching (Linux)

## Requirements

### Essential

- **Neovim** >= 0.11.\*
- **Git** >= 2.19.0
- **ripgrep** (rg) - Fast grep alternative for Telescope
- **fd** - Fast find alternative for file searching

### Optional but Recommended

- **Node.js** >= 14.0 - For many LSP servers
- **Python** >= 3.8 - For Python development and some plugins
- **Go** >= 1.19 - For Go development
- **Rust/Cargo** - For Rust development and some native plugins
- **lazygit** - Enhanced git interface
- **A Nerd Font** - For icon support (recommended: JetBrainsMono Nerd Font, FiraCode Nerd Font)

### System Dependencies by Feature

- **Clipboard**: xclip/xsel (Linux), pbcopy/pbpaste (macOS), win32yank (Windows)
- **Telescope**: make, gcc/clang for fzf-native
- **Fcitx**: fcitx5 (Linux only, for automatic input method switching)

## Installation

### Quick Start

```bash
# Backup existing configuration
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Clone this configuration
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

# Launch Neovim (plugins will auto-install)
nvim
```

### Install System Dependencies

#### Ubuntu/Debian

```bash
sudo apt update
sudo apt install neovim ripgrep fd-find nodejs npm python3 python3-pip
```

#### Arch Linux

```bash
sudo pacman -S neovim ripgrep fd nodejs npm python python-pip
```

#### macOS

```bash
brew install neovim ripgrep fd node python
```

#### Fedora

```bash
sudo dnf install neovim ripgrep fd-find nodejs python3 python3-pip
```

### Install Optional Tools

```bash
# Install lazygit
# See: https://github.com/jesseduffield/lazygit#installation

# Install a Nerd Font
# Download from: https://www.nerdfonts.com/
# Recommended: JetBrainsMono Nerd Font or FiraCode Nerd Font
```

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/               # Core configuration
│   │   ├── init.lua
│   │   ├── basic.lua       # Basic vim settings
│   │   ├── keymaps.lua     # Global keymaps
│   │   ├── auto-commands.lua
│   │   └── user-commands.lua
│   ├── lazy-nvim.lua       # Plugin manager setup
│   └── plugins/            # Plugin configurations
│       ├── lsp/            # LSP configurations
│       ├── git/            # Git-related plugins
│       ├── py/             # Python-specific plugins
│       └── helpers/        # UI/UX enhancements
├── ftplugin/               # Filetype-specific settings
└── lazy-lock.json          # Plugin version lock file
```

## Contributing

Feel free to fork this configuration and customize it to your needs. If you find bugs or have suggestions, please open an issue.

## License

MIT License - Feel free to use and modify as you wish.

## Acknowledgments

This configuration is built upon the amazing work of the Neovim and plugin community. Special thanks to:

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- And all other plugin authors
