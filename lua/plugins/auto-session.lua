return {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            -- Buffers with matching filetypes will be closed before saving
            close_filetypes_on_save = {
                "checkhealth",
                "json.lulala_ui",
            },
            suppressed_dirs = {
                "~/",
                "~/Projects",
                "~/Downloads",
                "/",
                "~/work",
                "~/github",
                "~/.local/share",
            },
        })
        vim.o.sessionoptions =
            "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
}
