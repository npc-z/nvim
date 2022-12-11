local status, auto_session = pcall(require, "auto-session")
if not status then
	vim.notify("没有安装插件: auto-save")
	return
end

auto_session.setup({
	log_level = "info",
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
	bypass_session_save_file_types = nil,
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

local status, session_lens = pcall(require, "session-lens")
if not status then
	vim.notify("没有安装插件: session-lens")
	return
end

session_lens.setup({
	-- path_display = { "shorten" },
	theme_conf = { border = true },
	previewer = false,
	prompt_title = "work sessions",
})

local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("没有安装插件: telescope")
	return
end

-- The plugin is lazy loaded when calling it for the first time but you
-- can pre-load it with Telescope like this if you'd
-- rather have autocomplete for it off the bat.
telescope.load_extension("session-lens")
