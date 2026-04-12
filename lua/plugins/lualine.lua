return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            "linrongbin16/lsp-progress.nvim",
            config = function()
                require("lsp-progress").setup()
            end,
        },
    },
    config = function()
        local lualine = require("lualine")

        local function git_blame()
            local blame = vim.b.gitsigns_blame_line
            if blame then
                return blame
            end
            return ""
        end

        lualine.setup({
            options = {
                theme = "auto",
                component_separators = { left = "|", right = "|" },
                -- https://github.com/ryanoasis/powerline-extra-symbols
                section_separators = { left = " ", right = "" },
            },

            --
            extensions = { "nvim-tree", "toggleterm" },

            --
            sections = {
                lualine_c = {
                    git_blame,
                    function()
                        -- invoke `progress` here.
                        return require("lsp-progress").progress()
                    end,
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        })
    end,
}
