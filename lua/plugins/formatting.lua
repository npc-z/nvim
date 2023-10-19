return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local conform = require("conform")

        conform.formatters.stylua = {
            prepend_args = {
                "--indent-type",
                "Spaces",
                "--quote-style",
                "ForceDouble",
                "--sort-requires",
                "--column-width",
                "88",
                "--indent-width",
                "4",
                "--call-parentheses",
                "Always",
            },
        }

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
            },

            format_after_save = {
                lsp_fallback = true,
            },

            format_on_save = {
                -- These options will be passed to conform.format()
                async = false,
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, {
            noremap = true,
            silent = true,
            desc = "Format file or range (in visual mode)",
        })
    end,
}
