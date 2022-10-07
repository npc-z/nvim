local status, db = pcall(require, "dashboard")
if not status then
	vim.notify("没有安装插件: dashboard")
	return
end

local function make_custom_footer()
	local datetime = os.date("%Y-%m-%d %H:%M:%S")
	local default_footer = { "", "Have fun with neovim", datetime }

	if packer_plugins ~= nil then
		local count = #vim.tbl_keys(packer_plugins)
		default_footer[3] = "loaded " .. count .. " plugins"
	end
	return default_footer
end

db.custom_footer = make_custom_footer()

db.custom_center = {
	{
		icon = "  ",
		desc = "Sessions                            ",
		action = "SearchSession",
	},
	{
		icon = "  ",
		desc = "Projects                            ",
		action = "Telescope projects",
	},
	{
		icon = "  ",
		desc = "Recently files                      ",
		action = "Telescope oldfiles",
	},
	{
		icon = "  ",
		desc = "Edit keybindings                    ",
		action = "edit ~/.config/nvim/lua/keybindings.lua",
	},
	{
		icon = "  ",
		desc = "Edit Projects                       ",
		action = "edit ~/.local/share/nvim/project_nvim/project_history",
	},
	-- {
	--   icon = "  ",
	--   desc = "Edit .bashrc                        ",
	--   action = "edit ~/.bashrc",
	-- },
	-- {
	-- 	icon = "  ",
	-- 	desc = "Change colorscheme                  ",
	-- 	action = "ChangeColorScheme",
	-- },
	{
		icon = "  ",
		desc = "Edit init.lua                       ",
		action = "edit ~/.config/nvim/init.lua",
	},
	{
		icon = "  ",
		desc = "Find file                           ",
		action = "Telescope find_files",
	},
	-- {
	-- 	icon = "  ",
	-- 	desc = "Find text                           ",
	-- 	action = "Telescopecope live_grep",
	-- },
	{
		icon = "  ",
		desc = "Quit                                ",
		action = "quit",
	},
}

db.custom_header = {
	[[]],
	[[███╗   ███╗ █████╗  ██████╗ ██╗   ██╗ █████╗ ]],
	[[████╗ ████║██╔══██╗██╔════╝ ██║   ██║██╔══██╗]],
	[[██╔████╔██║███████║██║  ███╗██║   ██║███████║]],
	[[██║╚██╔╝██║██╔══██║██║   ██║██║   ██║██╔══██║]],
	[[██║ ╚═╝ ██║██║  ██║╚██████╔╝╚██████╔╝██║  ██║]],
	[[╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝]],
	[[]],
	[[]],
	[[                    [麻瓜]                   ]],
	[[]],
	[[]],
}
