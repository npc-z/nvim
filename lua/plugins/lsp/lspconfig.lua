return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        {
            "rmagatti/goto-preview",
            event = "BufEnter",
            config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
        },
        {
            "dnlhc/glance.nvim",
            config = function()
                require("glance").setup({
                    -- your configuration
                })
            end,
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local utils = require("utils")

        -- use conform to formatting
        local formatter_disabled_lsps = {
            "clangd",
            "sqls",
        }

        local on_attach = function(client, bufnr)
            local illuminate = require("illuminate")
            illuminate.on_attach(client)

            if utils.has_value(formatter_disabled_lsps, client.name) then
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end

            require("plugins.lsp.after.lspkeymaps").setup_keymaps(bufnr)
        end

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- configure nix server
        -- lspconfig["nil_ls"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        -- })
        lspconfig["nixd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "nixd" },
            settings = {
                nixd = {
                    nixpkgs = {
                        expr = "import <nixpkgs> { }",
                    },
                    formatting = {
                        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
                    },
                    options = {
                        nixos = {
                            expr = "(builtins.getFlake \"/home/npc/.config/nixos\").nixosConfigurations.ser7-nixos.options",
                        },
                        home_manager = {
                            expr = "(builtins.getFlake \"/home/npc/.config/nixos\").homeConfigurations.ser7-nixos.options",
                        },
                    },
                },
            },
        })

        -- configure html server
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure typescript server with plugin
        lspconfig["ts_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure css server
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure tailwindcss server
        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure svelte server
        lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    callback = function(ctx)
                        if client.name == "svelte" then
                            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                        end
                    end,
                })
            end,
        })

        -- configure graphql language server
        lspconfig["graphql"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "graphql",
                "gql",
                "svelte",
                "typescriptreact",
                "javascriptreact",
            },
        })

        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })

        -- configure c/c++ server
        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {},
        })

        -- configure golang server
        lspconfig["gopls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = false,
                    analyses = {
                        unusedparams = true,
                    },
                },
            },
        })

        -- configure python server
        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "off",
                    },
                },
            },
        })

        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- configure rust server
        -- lspconfig["rust_analyzer"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = {
        --         cargo = { allFeatures = true },
        --     },
        -- })

        -- configure sqls server
        lspconfig["sqls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
