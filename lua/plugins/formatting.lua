return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local conform = require("conform")

        require("conform").formatters.sqlfluff = {
            inherit = false,
            command = "sqlfluff",
            args = { "fix", "--dialect=mysql", "-" },
        }

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
                    AllowShortBlocksOnASingleLine = "Never",
                    AllowShortIfStatementsOnASingleLine = "Never",
                    AllowShortFunctionsOnASingleLine = false,
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

        local fts = {
            c = { "clang_format" },
            lua = { "stylua" },
            -- python = { "isort", "black" },
            go = { "gofmt" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            -- json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            graphql = { "prettier" },
            nix = { "alejandra" },
            sql = { "sqlfluff" },
        }

        local handle = io.popen("uname -a")
        if handle ~= nil then
            local u = require("utils")
            local os_name = handle:read("*a")
            handle:close()

            local is_workstation = u.contains(os_name, "thinkpad")
            if is_workstation then
                -- do nothing now
            else
                fts.python = { "black", "isort" }
            end
        end

        conform.setup({
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = fts,

            -- If this is set, Conform will run the formatter asynchronously after save.
            format_after_save = {
                lsp_fallback = false,
            },

            format_on_save = {
                -- These options will be passed to conform.format()
                async = false,
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>fc", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })

            vim.cmd(":w")
        end, {
            noremap = true,
            silent = true,
            desc = "Format file or range (in visual mode)",
        })
    end,
}
