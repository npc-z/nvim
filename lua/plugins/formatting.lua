return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local conform = require("conform")

        conform.formatters.clang_format = {
            -- prepend_args = {
            --     "--style",
            --     "{ BasedOnStyle: Google, PointerAlignment: Left, IndentWidth: 4, ColumnLimit: 88}",
            -- },

            ---@diagnostic disable-next-line: unused-local
            prepend_args = function(ctx)
                local styles = {
                    BasedOnStyle = "Google",
                    PointerAlignment = "Left",
                    IndentWidth = 4,
                    ColumnLimit = 88,
                }
                return {
                    "--style",
                    vim.json.encode(styles),
                }
            end,
        }

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
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                c = { "clang_format" },
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
