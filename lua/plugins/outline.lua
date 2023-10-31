return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("aerial").setup({
            -- These control the width of the aerial window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a list of mixed types.
            -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
            max_width = { 0.4 },

            -- List of enum values that configure when to auto-close the aerial window
            --   unfocus       - close aerial when you leave the original source window
            --   switch_buffer - close aerial when you change buffers in the source window
            --   unsupported   - close aerial when attaching to a buffer that has no symbol source
            close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },

            -- When true, aerial will automatically close after jumping to a symbol
            close_on_select = true,
        })
        -- You probably also want to set a keymap to toggle aerial
        vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>")
    end,
}
