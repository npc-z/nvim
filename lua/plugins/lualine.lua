return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress",
    },
    config = function()
        local lualine = require("lualine")

        local count_cur_buf_words = require("wordcounter").count_cur_buf_words
        local function words()
            return "W:" .. count_cur_buf_words()
        end

        local function total_lines()
            return "L:" .. vim.api.nvim_buf_line_count(0)
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
                        "filename",
                        -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        path = 1,
                    },
                    {
                        "lsp_progress",
                        spinner_symbols = {
                            " ",
                            " ",
                            " ",
                            " ",
                            " ",
                            " ",
                        },
                    },
                },
                lualine_x = {
                    "filesize",
                    total_lines,
                    words,
                    {
                        "fileformat",
                        -- symbols = {
                        --   unix = '', -- e712
                        --   dos = '', -- e70f
                        --   mac = '', -- e711
                        -- },
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR",
                        },
                    },
                    "encoding",
                    "filetype",
                },
            },
        })
    end,
}
