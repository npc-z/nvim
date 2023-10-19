return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_session_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = true,
            auto_session_suppress_dirs = {
                "~/",
                "~/Projects",
                "~/Downloads",
                "/",
                "~/work",
                "~/github",
                "~/.local/share",
            },
            -- the configs below are lua only
            bypass_session_save_file_types = {},
        })
        vim.o.sessionoptions =
            "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
}
