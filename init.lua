-- 基础配置
require("basic")
-- 快捷键
require("keybindings")
-- 插件
require("plugins")
-- 主题
require("colorscheme")
--
-- 插件配置
--
-- 文件树
require("plugin-config.nvim-tree")
-- buffer
require("plugin-config.bufferline")
-- lualine
require("plugin-config.lualine")
-- telescope
require("plugin-config.telescope")
-- dashboard
require("plugin-config.dashboard")
-- project
require("plugin-config.project")
--
require("plugin-config.nvim-treesitter")
--
require("plugin-config.indent-blankline")

--
-- lsp config
--
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")

