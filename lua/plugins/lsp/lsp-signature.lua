return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
        require("lsp_signature").setup({
            -- Panda for parameter,
            -- NOTE: for the terminal not support emoji, might crash
            hint_prefix = " ",
        })
    end,
}
