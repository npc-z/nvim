return {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
    dependencies = {
        {
            "saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
        },
    },
    config = function()
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
