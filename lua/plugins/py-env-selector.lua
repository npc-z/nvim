-- python env selector
return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python", --optional
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
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
