local require_fail_and_continue = require("utils").require_fail_and_continue

-- 基础配置
local function init_basic()
	-- 基础设置
	require_fail_and_continue("basic")
	-- 基础快捷键
	require_fail_and_continue("basic-keybindings")
	-- 插件快捷键
	require_fail_and_continue("plugins-keybindings")
	-- 自定义命令
	require_fail_and_continue("auto-commands")
	-- 插件管理
	require_fail_and_continue("plugins")
	-- 主题
	require_fail_and_continue("colorscheme")
end

local function init_web_dev_plugin()
	-- http rest
	require_fail_and_continue("plugin-config.http-rest")
end

-- 插件配置
local function init_plugin()
	-- 文件树
	require_fail_and_continue("plugin-config.nvim-tree")
	-- buffer
	require_fail_and_continue("plugin-config.bufferline")
	-- lualine
	require_fail_and_continue("plugin-config.lualine")
	-- telescope
	require_fail_and_continue("plugin-config.telescope")
	-- dashboard
	require_fail_and_continue("plugin-config.dashboard")
	-- project
	require_fail_and_continue("plugin-config.project")
	require_fail_and_continue("plugin-config.auto-session")
	-- 语法高亮
	require_fail_and_continue("plugin-config.nvim-treesitter")
	-- 缩进竖线
	require_fail_and_continue("plugin-config.indent-blankline")
	-- 成对括号
	require_fail_and_continue("plugin-config.nvim-autopairs")
	-- 注释
	require_fail_and_continue("plugin-config.comment")
	-- smooth move
	require_fail_and_continue("plugin-config.neoscroll")
	require_fail_and_continue("plugin-config.hop")
	-- markdown preview
	require_fail_and_continue("plugin-config.glow")
	-- auto save buffer
	require_fail_and_continue("plugin-config.auto-save")
	-- 行尾空格高亮
	require_fail_and_continue("plugin-config.better-whitespace")
	-- toggleterm
	require_fail_and_continue("plugin-config.toggleterm")
	-- git
	require_fail_and_continue("plugin-config.gitsigns")
	require_fail_and_continue("plugin-config.diffview")
	-- 显示快捷键
	require_fail_and_continue("plugin-config.which-key")
	-- nofity
	require_fail_and_continue("plugin-config.notify")
	-- trouble
	require_fail_and_continue("plugin-config.trouble")
	--
	init_web_dev_plugin()
end

-- lsp config
local function init_lsp()
	--
	require_fail_and_continue("lsp.setup")
	--
	require_fail_and_continue("lsp.cmp")
	--
	require_fail_and_continue("lsp.ui")
	--
	require_fail_and_continue("lsp.null-ls")
	--
	require_fail_and_continue("plugin-config.illuminate")
end

local function main()
	init_basic()
	init_plugin()
	init_lsp()
end

main()
--
