local auto_session_status, auto_session = pcall(require, "auto-session")
if not auto_session_status then
    vim.notify("没有安装插件: auto-session")
    return
end

auto_session.setup({
    -- log_level = "info",
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_use_git_branch = nil,
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

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
