-- python env selector
return {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        -- for debugger
        -- "mfussenegger/nvim-dap-python",
    },

    keys = {
        -- open VenvSelector to pick a venv.
        { "<leader>vs", "<cmd>VenvSelect<cr>" },
        -- retrieve the venv from a cache
        -- the one previously used for the same project directory.
        { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },

    config = function()
        require("venv-selector").setup({
            name = {
                "venv",
                ".venv",
            },
        })
    end,
}
