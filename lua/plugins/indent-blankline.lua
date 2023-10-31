return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
        indent = {
            char = "│",
        },
        scope = {
            enabled = true,
        },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "Trouble",
                "lazy",
                "neo-tree",
            },
        },
    },
}
