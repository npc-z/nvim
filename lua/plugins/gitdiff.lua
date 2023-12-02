-- git diff view / file history

return {
    "sindrets/diffview.nvim",
    config = function()
        require("diffview").setup({
            view = {
                -- Configure the layout and behavior of different types of views.
                -- Available layouts:
                --  'diff1_plain'
                --    |'diff2_horizontal'
                --    |'diff2_vertical'
                --    |'diff3_horizontal'
                --    |'diff3_vertical'
                --    |'diff3_mixed'
                --    |'diff4_mixed'
                -- For more info, see ':h diffview-config-view.x.layout'.
                merge_tool = {
                    -- Config for conflicted files in diff views during a merge or rebase.
                    layout = "diff3_horizontal",
                },
            },
        })

        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        local opts_with_desc = function(desc)
            return vim.tbl_deep_extend("force", opts, { desc = desc })
        end

        map(
            "n",
            "<leader>gdc",
            ":DiffviewClose<CR>",
            opts_with_desc("[G]it [D]iiffview [C]lose")
        )
        map(
            "n",
            "<leader>gdo",
            ":DiffviewOpen<CR>",
            opts_with_desc("[G]it [D]iffview [O]pen")
        )
        map(
            "n",
            "<leader>gdf",
            ":DiffviewFileHistory %<CR>",
            opts_with_desc("[G]it [D]iffview The Current [F]ile History")
        )
        map(
            "v",
            "<leader>gdf",
            ":'<,'>DiffviewFileHistory %<CR>",
            opts_with_desc(
                "[G]it [D]iffview The Current [F]ile History On The Selected Lines"
            )
        )
    end,
}
