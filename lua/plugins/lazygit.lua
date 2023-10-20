return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- scaling factor for floating window
        vim.g.lazygit_floating_window_scaling_factor = 1

        vim.api.nvim_set_keymap(
            "n",
            "<leader>lg",
            ":LazyGit<CR>",
            { noremap = true, silent = true, desc = "LazyGit" }
        )
    end,
}
