-- Display one line diagnostic messages where the cursor is, with icons and colors

return {
    "rachartier/tiny-inline-diagnostic.nvim",
    -- event = "VeryLazy", -- Or `LspAttach`
    -- priority = 9990000, -- needs to be loaded in first
    priority = 1000, -- needs to be loaded in first
    config = function()
        -- remove all the others diagnostics.
        vim.diagnostic.config({ virtual_text = false })

        require("tiny-inline-diagnostic").setup({
            options = {
                -- Show the source of the diagnostic.
                show_source = true,
                virt_texts = {
                    priority = 9048,
                },
            },
        })
    end,
}
