return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.api.nvim_set_keymap(
            "n",
            "<leader>lg",
            ":LazyGit<CR>",
            { noremap = true, silent = true, desc = "LazyGit" }
        )
    end,
}
