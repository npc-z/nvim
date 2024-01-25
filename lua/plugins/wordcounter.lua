return {
    "npc-z/wordcounter.nvim",
    -- dir = "/home/npc/github/lua/wordcounter.nvim",
    dependencies = {
        "uga-rosa/utf8.nvim",
    },
    config = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        local opts_with_desc = function(desc)
            return vim.tbl_deep_extend("force", opts, { desc = desc })
        end

        map(
            "v",
            "<leader>ws",
            "<cmd>WordSelectedCount<CR>",
            opts_with_desc("WordSelectedCount")
        )
    end,
}
