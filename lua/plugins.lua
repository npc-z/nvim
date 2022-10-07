local packer = require("packer")

local home_dir = os.getenv("HOME")
local nvim_config_path = home_dir .. "/.config/nvim/"

packer.startup({
	function(use)
		-- Packer 可以管理自己本身
		use("wbthomason/packer.nvim")

		-- tokyonight
		use("folke/tokyonight.nvim")

		-- nvim-tree
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

		-- bufferline
		use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons" } })

		-- lualine
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		use("arkav/lualine-lsp-progress")

		-- telescope
		-- https://github.com/BurntSushi/ripgrep
		-- https://github.com/sharkdp/fd
		use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

		-- 启动页
		use("glepnir/dashboard-nvim")
		-- 项目
		use("ahmedkhalf/project.nvim")
		use({ "rmagatti/auto-session" })
		use({
			"rmagatti/session-lens",
			requires = { "nvim-telescope/telescope.nvim" },
		})
		-- treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		-- lsp
		use("williamboman/nvim-lsp-installer")
		-- Lspconfig
		use({ "neovim/nvim-lspconfig" })

		-- 补全引擎
		use("hrsh7th/nvim-cmp")
		-- use("L3MON4D3/LuaSnip")
		-- snippet 引擎
		use("hrsh7th/vim-vsnip")
		-- use("saadparwaiz1/cmp_luasnip")

		-- 补全源
		-- use("hrsh7th/cmp-vsnip")
		use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
		use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
		use("hrsh7th/cmp-path") -- { name = 'path' }
		use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

		-- 常见编程语言代码段
		use("rafamadriz/friendly-snippets")

		-- ui
		use("onsails/lspkind-nvim")

		-- indent-blankline
		use("lukas-reineke/indent-blankline.nvim")

		--
		use("glepnir/lspsaga.nvim")

		-- 格式化
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

		-- 成对括号
		use("windwp/nvim-autopairs")

		-- 注释
		use("numToStr/Comment.nvim")

		-- 丝滑的移动
		use("karb94/neoscroll.nvim")

		-- markdown preview
		use({ "ellisonleao/glow.nvim" })

		-- auto-save
		use({ "Pocco81/auto-save.nvim" })

		-- 显示空格
		use({ "ntpeters/vim-better-whitespace" })

		-- git
		use({ "lewis6991/gitsigns.nvim" })
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

		-- tool notify
		use({ "rcarriga/nvim-notify" })

		-- 开关终端
		use({ "akinsho/toggleterm.nvim", tag = "v2.2.1" })
		-- 显示 keymap
		use({ "folke/which-key.nvim" })

		-- 行内快速跳转提示
		use("unblevable/quick-scope")

		-- web dev
		-- http restful
		use({ "rest-nvim/rest.nvim", requires = "nvim-lua/plenary.nvim" })
	end,

	config = {
		-- 快照保存位置目录, 使用绝对路径, 否则每个打开的项目都会创建此目录
		snapshot_path = nvim_config_path .. "snapshot",
		-- Name of the snapshot you would like to load at startup
		snapshot = "v1.7",
		-- 并发数限制
		max_jobs = 16,
		--
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		-- 自定义源
		git = {
			-- default_url_format = "https://hub.fastgit.xyz/%s",
			-- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
			-- default_url_format = "https://gitcode.net/mirrors/%s",
			-- default_url_format = "https://gitclone.com/github.com/%s",
		},
	},
})

-- 每次保存 plugins.lua 自动安装插件
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- autocmd BufWritePost plugins.lua source <afile> | PackerCompile
pcall(
	vim.cmd,
	[[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]]
)
