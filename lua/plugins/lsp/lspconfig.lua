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

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        utils.config_diagnostic()

        -- configure nix server
        -- vim.lsp.config("nil_ls", {
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        -- })
        vim.lsp.config("nixd", {
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
        vim.lsp.config("html", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure typescript server with plugin
        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure css server
        vim.lsp.config("cssls", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure tailwindcss server
        vim.lsp.config("tailwindcss", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure svelte server
        vim.lsp.config("svelte", {
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
        vim.lsp.config("graphql", {
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
        vim.lsp.config("emmet_ls", {
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
        vim.lsp.config("clangd", {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {},
        })

        -- configure golang server
        vim.lsp.config("gopls", {
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
        vim.lsp.enable("pyright")
        vim.lsp.config("pyright", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure lua server (with special settings)
        vim.lsp.config("lua_ls", {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (
                            vim.uv.fs_stat(path .. "/.luarc.json")
                            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                        )
                    then
                        return
                    end
                end

                client.config.settings.Lua =
                    vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                "lua/?.lua",
                                "lua/?/init.lua",
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- Depending on the usage, you might want to add additional paths
                                -- here.
                                -- '${3rd}/luv/library'
                                -- '${3rd}/busted/library'
                            },
                            -- Or pull in all of 'runtimepath'.
                            -- NOTE: this is a lot slower and will cause issues when working on
                            -- your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            -- library = {
                            --   vim.api.nvim_get_runtime_file('', true),
                            -- }
                        },
                    })
            end,
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        -- configure rust server
        -- vim.lsp.config("rust_analyzer", {
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = {
        --         cargo = { allFeatures = true },
        --     },
        -- })

        -- configure sqls server
        vim.lsp.config("sqls", {
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
