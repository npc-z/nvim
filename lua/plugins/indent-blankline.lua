return {
    "lukas-reineke/indent-blankline.nvim",
    -- cond = function()
    --     return vim.g.vscode == nil
    -- end,
    main = "ibl",
    opts = {
        scope = {
            enabled = true,
        },
        exclude = {
            filetypes = { "dashboard" },
        },
    },
}
