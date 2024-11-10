return {
    "davidmh/cspell.nvim",
    dependencies = {
        "mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        local none_ls = require("null-ls")
        local cspell = require("cspell")

        local config = {
            -- The CSpell configuration file can take a few different names this option
            -- lets you specify which name you would like to use when creating a new
            -- config file from within the `Add word to cspell json file` action.
            --
            -- See the currently supported files in https://github.com/davidmh/cspell.nvim/blob/main/lua/cspell/helpers.lua
            config_file_preferred_name = ".cspell.json",

            -- A list of directories that contain additional cspell.json config files or
            -- support the creation of a new config file from a code action
            --
            -- looks for a cspell config in the ~/.config/ directory, or creates a file in the directory
            -- using 'config_file_preferred_name' when a code action for one of the locations is selected
            cspell_config_dirs = {
                "~/.config/nvim/",
            },

            on_add_to_json = function(payload)
                -- Includes:
                -- payload.new_word
                -- payload.cspell_config_path
                -- payload.generator_params

                -- For example, you can format the cspell config file after you add a word
                os.execute(
                    string.format(
                        "jq -S '.words |= sort' %s > %s.tmp && mv %s.tmp %s",
                        payload.cspell_config_path,
                        payload.cspell_config_path,
                        payload.cspell_config_path,
                        payload.cspell_config_path
                    )
                )
            end,
        }

        none_ls.setup({
            sources = {
                cspell.diagnostics.with({ config = config }),
                cspell.code_actions.with({ config = config }),
            },
        })
    end,
}
