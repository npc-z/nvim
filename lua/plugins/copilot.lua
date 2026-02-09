return {
    "zbirenbaum/copilot.lua",
    dependencies = {
        -- (optional) for NES functionality
        -- "copilotlsp-nvim/copilot-lsp",
    },

    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
            -- suggestion = {
            --     enabled = true,
            --     auto_trigger = true,
            -- },
        })
    end,
}
