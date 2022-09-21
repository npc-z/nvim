local packer = require("packer")

packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'

    -- tokyonight
    use "folke/tokyonight.nvim"

    -- nvim-tree
    use ({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

    -- bufferline
    use ({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons" }})

    -- lualine
    use ({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" }})
    use "arkav/lualine-lsp-progress"

    -- telescope
    -- https://github.com/BurntSushi/ripgrep
    -- https://github.com/sharkdp/fd
    use ({ 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" }})

    -- 启动页
    use 'glepnir/dashboard-nvim'
    -- 项目
    use "ahmedkhalf/project.nvim"

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  end,

  config = {
    -- 并发数限制
    max_jobs = 4,
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
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]]
)

