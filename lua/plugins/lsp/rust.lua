return {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    dependencies = {
        {
            "saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
        },
    },
    config = function()
        local on_attach = function(client, bufnr)
            local illuminate = require("illuminate")
            illuminate.on_attach(client)

            require("plugins.lsp.after.lspkeymaps").setup_keymaps(bufnr)
        end

        vim.g.rustaceanvim = {
            -- Plugin configuration
            -- tools = {},
            -- LSP configuration
            server = {
                on_attach = on_attach,
                default_settings = {
                    -- rust-analyzer language server configuration
                    -- ["rust-analyzer"] = {},
                },
            },
            -- DAP configuration
            -- dap = {},
        }

        require("crates").setup({
            lsp = {
                enabled = true,
                on_attach = on_attach,
                actions = true,
                completion = true,
                hover = true,
            },
        })
    end,
}
