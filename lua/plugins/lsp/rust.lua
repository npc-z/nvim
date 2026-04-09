return {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    dependencies = {
        {
            "saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
        },
    },
    config = function()
        vim.g.rustaceanvim = {
            server = {
                -- on_attach is handled by the global LspAttach autocmd
                -- in lua/plugins/lsp/lspconfig.lua
                default_settings = {
                    -- rust-analyzer language server configuration
                    -- ["rust-analyzer"] = {},
                },
            },
        }

        require("crates").setup({
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        })
    end,
}
