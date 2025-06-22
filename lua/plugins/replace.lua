-- A search panel for neovim.

return {
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        local far = require("grug-far")
        far.setup({
            -- options, see Configuration section below
            -- there are no required options atm
        })

        vim.keymap.set({ "n", "x" }, "<leader>F", function()
            far.open({ visualSelectionUsage = "operate-within-range" })
        end, { desc = "grug-far: Search within range" })
    end,
}
