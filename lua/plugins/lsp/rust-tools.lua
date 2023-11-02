return {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
        local rt = require("rust-tools")

        rt.setup({
            -- all the opts to send to nvim-lspconfig
            -- these override the defaults set by rust-tools.nvim
            -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            -- rust-analyzer options
            server = {
                -- standalone file support
                -- setting it to false may improve startup time
                standalone = true,
                on_attach = function(client, bufnr)
                    require("plugins.lsp.after.lspkeymaps").setup_keymaps(bufnr)
                end,
            },
        })
    end,
}
