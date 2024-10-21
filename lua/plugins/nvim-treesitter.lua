return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },

    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            -- enable syntax highlighting
            highlight = {
                enable = true,
            },
            -- enable indentation
            indent = { enable = true },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
                enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "python",
                "go",
                "http",
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "graphql",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "query",
                "just",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = false, -- set to `false` to disable one of the mappings
                    scope_incremental = "grc",
                    node_incremental = "<Enter>",
                    node_decremental = "<bs>",
                },
            },
        })

        -- 开启 Folding 模块
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        -- 默认不要折叠
        -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
        vim.opt.foldlevel = 99
    end,
}
