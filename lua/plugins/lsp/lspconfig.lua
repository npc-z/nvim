return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- Shared capabilities for all LSP servers (blink.cmp integration)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        -- LSP servers that should not provide formatting (use conform instead)
        local formatter_disabled_lsps = { "clangd", "sqls" }

        -- LspAttach: unified handler for keymaps, illuminate, etc.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client then
                    return
                end

                local bufnr = ev.buf

                -- codelens & inlay_hint
                vim.lsp.codelens.enable(false)
                vim.lsp.inlay_hint.enable(false)

                -- Highlight other uses of the word under cursor
                require("illuminate").on_attach(client)

                -- Disable formatting for specific LSP servers
                local utils = require("utils")
                if utils.has_value(formatter_disabled_lsps, client.name) then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                -- Buffer-local keymaps
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(
                        mode,
                        lhs,
                        rhs,
                        { buffer = bufnr, noremap = true, silent = true, desc = desc }
                    )
                end

                -- Navigation (Telescope integration)
                map(
                    "n",
                    "gd",
                    "<cmd>Telescope lsp_definitions<CR>",
                    "LSP definitions (Telescope)"
                )
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

                -- Code actions & rename
                -- default map is `grn`
                map({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action, "Code actions")
                map(
                    "n",
                    "<leader>rn",
                    require("live-rename").rename,
                    "LSP rename (live)"
                )

                -- Diagnostics
                map(
                    "n",
                    "<leader>D",
                    "<cmd>Telescope diagnostics bufnr=0<CR>",
                    "Buffer diagnostics"
                )
                map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
                map("n", "[d", function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, "Previous diagnostic")
                map("n", "]d", function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, "Next diagnostic")

                -- Info & help
                map("n", "gh", vim.lsp.buf.hover, "Hover documentation")
                map("n", "<leader>k", vim.lsp.buf.signature_help, "Signature help")

                -- Utility
                -- map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
                map("n", "<leader>i", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, "Toggle inlay hints")

                map("n", "<leader>tc", function()
                    vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
                end, "Toggle codelens")
            end,
        })

        -- Enable all LSP servers
        vim.lsp.enable({
            "nixd",
            "tix",
            "html",
            "ts_ls",
            "cssls",
            "tailwindcss",
            "svelte",
            "graphql",
            "emmet_ls",
            "clangd",
            "gopls",
            "zuban",
            "lua_ls",
            "sqls",
            "jdtls",
            "harper_ls", -- a grammar checker, https://writewithharper.com/docs/integrations/language-server
        })
    end,
}
