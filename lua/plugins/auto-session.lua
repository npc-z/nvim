return {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
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
