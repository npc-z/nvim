return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    branch = "main",

    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
        "windwp/nvim-ts-autotag",
    },

    config = function()
        local ensureInstalled = {
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
        }

        local ts = require("nvim-treesitter")
        local alreadyInstalled = ts.get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        ts.install(parsersToInstall)

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
}
