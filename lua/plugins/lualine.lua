return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress",
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
                    {
                        git_blame,
                        "lsp_progress",
                        spinner_symbols = {
                            "🌑 ",
                            "🌒 ",
                            "🌓 ",
                            "🌔 ",
                            "🌕 ",
                            "🌖 ",
                            "🌗 ",
                            "🌘 ",
                        },
                    },
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
