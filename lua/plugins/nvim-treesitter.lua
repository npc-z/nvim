return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
        "windwp/nvim-ts-autotag",
    },

    config = function()
        local treesitter = require("nvim-treesitter.configs")

        -- 开启 Folding 模块
        -- vim.opt.foldmethod = "expr"
        -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        -- 默认不要折叠
        -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
        -- vim.opt.foldlevel = 99

        treesitter.setup({ -- enable syntax highlighting
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
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}
