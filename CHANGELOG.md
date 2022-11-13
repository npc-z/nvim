change log


## v2.3
> 2022-11-13

- add plugin: nvim-treesitter-context, act as vscode's sticky scroll
- do not hook vim.notify by notify plugin
- turn off pyright type check

## v2.2
> 2022-11-09

- add plugin: illuminate for automatically highlighting other uses of the word under the cursor
- update some keymaps


## v2.1
> 2022-11-07

- add plugin: trouble
- update some keymaps


## v2.0
> 2022-10-30

- use mason insead of lsp-installer
- re-config lsp server
- some other keymaps change


## v1.9
> 2022-10-30

- change to use nvim 0.8.0
- update some config to suit new nvim


## v1.8
> 2022-10-29

- add plugin: hop.nvim, for quickly jump
- do not use snapshop and always update plugins


## v1.7
> 2022-10-07

- add plugins(auto-session/session-lens) for work session manager
- update some keymaps

## v1.6
> 2022-10-07

- add plugin quick-scope to help move within line quickly
- add plugins of git(gitsigns and diffview) and remove the git-blame and gitgutter
- update dashboard footer
- update lsp server setup method
- update some keymaps


## v1.5
> 2022-10-02

- 添加插件 rest-nvim/rest.nvim, 方便测试 http api
- fix snapshop path
- fix past in v mode and config clipboard
- format some code
- 调整补全时的样式, 调整补全时 tab 键功能


## v1.4
> 2022-09-25

- 添加插件: https://github.com/folke/which-key.nvim, 显示快捷键
- 配置 vim-gitgutter


## v1.3
- add auto-save plugin
- add toggleterm 插件, 更好的终端
- 调整 init.lua 的引入机制(跳过失败引入)
- 调整基础快捷键
- 添加 auto-command
- 自定义 utils
- 格式化代码
