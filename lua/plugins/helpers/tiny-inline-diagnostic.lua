-- Display one line diagnostic messages where the cursor is, with icons and colors

return {
    "rachartier/tiny-inline-diagnostic.nvim",
    -- event = "VeryLazy", -- Or `LspAttach`
    -- priority = 9990000, -- needs to be loaded in first
    priority = 1000, -- needs to be loaded in first
    config = function()
        local utils = require("utils")
        vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics

        require("tiny-inline-diagnostic").setup({
            options = {
                -- Show the source of the diagnostic.
                show_source = true,
                -- Virtual text display priority
                -- Higher values appear above other plugins (e.g., GitBlame)
                virt_texts = {
                    priority = 9000,
                },

                -- Use icons from vim.diagnostic.config instead of preset icons
                use_icons_from_diagnostic = true,
            },
        })
    end,
}
