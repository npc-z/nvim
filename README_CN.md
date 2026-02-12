# Neovim 配置

一个现代化、功能丰富的 Neovim 配置，专注于开发效率和工作流优化。

[English Documentation](./README.md)

## 特性

### 核心功能

- **LSP 支持**: 完整的语言服务器协议集成,包括自动补全、诊断和代码操作
- **智能补全**: 基于 blink.cmp 提供补全功能,集成 Copilot 和缓冲区词汇建议
- **语法高亮**: 通过 nvim-treesitter 提供先进的语法高亮
- **文件导航**: 使用 Telescope 进行模糊查找,使用 Neo-tree 提供层级化文件浏览器
- **Git 集成**: 通过 lazygit、gitsigns、diffview 等插件提供完整的 git 工作流
- **调试功能**: 完整的 DAP(调试适配器协议)支持及可视化界面
- **会话管理**: 自动保存和恢复会话
- **终端集成**: 通过 toggleterm 提供集成终端

### 语言支持

- **Python**: 增强的 Python 支持,包括虚拟环境选择器和 DAP 调试
- **Go**: 通过 go.nvim 提供完整的 Go 开发支持
- **Rust**: 通过 rustaceanvim 提供完整的 Rust 支持
- **Java**: Spring Boot 和通用 Java 开发支持
- **Haskell**: 专门的 Haskell 工具支持
- **Web 开发**: HTML、CSS、JavaScript/TypeScript,支持自动标签补全
- **数据库**: 通过 nvim-dbee 提供 SQL 编辑和数据库管理
- **HTTP 测试**: 通过 kulala.nvim 进行 API 测试
- **Markdown**: 增强的 markdown 渲染和编辑功能

### UI/UX 增强

- **配色方案**: Kanagawa 主题
- **状态栏**: 功能丰富的 lualine,显示 LSP 进度
- **缓冲区栏**: 优雅的缓冲区管理界面
- **启动界面**: 自定义启动屏幕
- **快捷键提示**: 交互式的快捷键帮助系统
- **代码大纲**: 通过 aerial.nvim 进行符号导航
- **平滑滚动**: 通过 neoscroll 增强滚动体验
- **缩进指示**: 可视化缩进指示器
- **顶栏/面包屑**: 上下文导航面包屑

### 效率工具

- **Flash**: 闪电般快速的光标移动
- **Grug-far**: 高级搜索和替换功能
- **Comment**: 智能注释工具
- **Autopairs**: 自动括号配对
- **Todo Comments**: 高亮和管理 TODO/FIXME/NOTE 注释
- **Undotree**: 可视化撤销历史
- **Word Counter**: 文档统计工具
- **Live Rename**: 实时 LSP 重命名预览
- **Fcitx 集成**: 自动输入法切换(Linux)

## 系统要求

### 必需

- **Neovim** >= 0.11.\*
- **Git** >= 2.19.0
- **ripgrep** (rg) - 用于 Telescope 的快速搜索
- **fd** - 用于文件搜索的快速查找工具

### 可选但推荐

- **Node.js** >= 14.0 - 许多 LSP 服务器需要
- **Python** >= 3.8 - Python 开发和部分插件需要
- **Go** >= 1.19 - Go 开发需要
- **Rust/Cargo** - Rust 开发和部分原生插件需要
- **lazygit** - 增强的 git 界面
- **Nerd Font** - 图标支持(推荐: JetBrainsMono Nerd Font、FiraCode Nerd Font)

### 功能依赖

- **剪贴板**: xclip/xsel (Linux)、pbcopy/pbpaste (macOS)、win32yank (Windows)
- **Telescope**: make、gcc/clang(用于编译 fzf-native)
- **Fcitx**: fcitx5 (仅 Linux,用于自动输入法切换)

## 安装

### 快速开始

```bash
# 备份现有配置
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# 克隆此配置
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

# 启动 Neovim(插件将自动安装)
nvim
```

### 安装系统依赖

#### home-manager

```nix
{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    withNodeJs = true;
    withPython3 = true;
    extraPython3Packages = pyPkgs:
      with pyPkgs; [
        autopep8
      ];

    # defaultEditor = true;
    extraPackages = with pkgs; [
      # formatter for nix
      alejandra

      go
      cargo
      luajit # required by plugin's building
      stylua
      lua-language-server

      fd
      ripgrep
      gzip
      zip
      unzip
      gnutar
      wget
      curl

      # for neovim & rust
      graphviz # Graph visualization tools

      # sql
      vimPlugins.nvim-dbee # not support on darwin
      sleek
    ];

    plugins = with pkgs.vimPlugins; [
      # nvim-dbee not work, put it at extraPackages
    ];
  };
}
```

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

### 安装可选工具

```bash
# 安装 lazygit
# 参见: https://github.com/jesseduffield/lazygit#installation

# 安装 Nerd Font
# 下载地址: https://www.nerdfonts.com/
# 推荐: JetBrainsMono Nerd Font 或 FiraCode Nerd Font
```

## 目录结构

```
~/.config/nvim/
├── init.lua                 # 入口文件
├── lua/
│   ├── core/               # 核心配置
│   │   ├── init.lua
│   │   ├── basic.lua       # 基础 vim 设置
│   │   ├── keymaps.lua     # 全局快捷键
│   │   ├── auto-commands.lua
│   │   └── user-commands.lua
│   ├── lazy-nvim.lua       # 插件管理器设置
│   └── plugins/            # 插件配置
│       ├── lsp/            # LSP 配置
│       ├── git/            # Git 相关插件
│       ├── py/             # Python 专用插件
│       └── helpers/        # UI/UX 增强
├── ftplugin/               # 文件类型特定设置
└── lazy-lock.json          # 插件版本锁定文件
```

## 贡献

欢迎 fork 此配置并根据您的需求进行自定义。如果发现问题或有建议,请提交 issue。

## 许可证

MIT License - 您可以自由使用和修改。

## 致谢

此配置基于 Neovim 和插件社区的出色工作。特别感谢:

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- 以及所有其他插件作者
