local fn = vim.fn

local home_dir = os.getenv("HOME")
local nvim_config_path = home_dir .. "/.config/nvim/"

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.notify("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

packer.startup({
    function(use)
        -- Packer 可以管理自己本身
        use("wbthomason/packer.nvim")

        -- tokyonight
        use("folke/tokyonight.nvim")
        use("rebelot/kanagawa.nvim")

        -- nvim-tree
        -- use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            }
        }

        -- bufferline
        use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = { "kyazdani42/nvim-web-devicons" } })

        -- lualine
        use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
        use("arkav/lualine-lsp-progress")

        -- telescope
        -- https://github.com/BurntSushi/ripgrep
        -- https://github.com/sharkdp/fd
        use({ "nvim-telescope/telescope.nvim", branch = '0.1.x', requires = { "nvim-lua/plenary.nvim" } })

        -- 启动页
        use("glepnir/dashboard-nvim")

        -- 项目
        use("ahmedkhalf/project.nvim")
        use({ "rmagatti/auto-session" })

        -- treesitter
        use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
        use("nvim-treesitter/nvim-treesitter-context")

        -- lsp
        use({
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        })
        -- 补全引擎
        use("hrsh7th/nvim-cmp")
        -- use("L3MON4D3/LuaSnip")
        -- snippet 引擎
        use("hrsh7th/cmp-vsnip")
        use("hrsh7th/vim-vsnip")
        -- use("saadparwaiz1/cmp_luasnip")
        -- 补全源
        -- use("hrsh7th/cmp-vsnip")
        use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
        use("hrsh7th/cmp-buffer")   -- { name = 'buffer' },
        use("hrsh7th/cmp-path")     -- { name = 'path' }
        use("hrsh7th/cmp-cmdline")  -- { name = 'cmdline' }
        use("ray-x/lsp_signature.nvim")

        -- 常见编程语言代码段
        use("rafamadriz/friendly-snippets")

        -- Automatically highlighting other uses of the word under the cursor
        use("RRethy/vim-illuminate")

        -- rust
        use 'simrat39/rust-tools.nvim'

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
        -- use({ "Pocco81/auto-save.nvim" })

        -- 显示空格
        use({ "ntpeters/vim-better-whitespace" })

        -- git
        use({
            "lewis6991/gitsigns.nvim",
            tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
        })
        use({
            "kdheepak/lazygit.nvim",
            -- optional for floating window border decoration
            requires = {
                "nvim-lua/plenary.nvim",
            },
        })
        -- like local history
        use("mbbill/undotree")

        -- tool notify
        use({ "rcarriga/nvim-notify" })

        -- 开关终端
        use({ "akinsho/toggleterm.nvim", tag = "v2.2.1" })
        -- 显示 keymap
        use({ "folke/which-key.nvim" })

        -- 行内快速跳转提示
        use("unblevable/quick-scope")
        use({
            "phaazon/hop.nvim",
            branch = "v2", -- optional but strongly recommended
        })

        -- web dev
        -- http restful
        use({ "rest-nvim/rest.nvim", requires = "nvim-lua/plenary.nvim" })

        -- trouble list
        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
        })

        -- 单词补全
        use("skywind3000/vim-dict")
        use("skywind3000/vim-auto-popmenu")
    end,
    config = {
        -- 快照保存位置目录, 使用绝对路径, 否则每个打开的项目都会创建此目录
        snapshot_path = nvim_config_path .. "snapshot",
        -- Name of the snapshot you would like to load at startup
        -- snapshot = "v1.7",
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
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])
