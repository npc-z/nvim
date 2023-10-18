local status, db = pcall(require, "dashboard")
if not status then
    vim.notify("没有安装插件: dashboard")
    return
end

db.setup({
    theme = 'hyper',
    config = {
        week_header = {
            enable = true,
        },
        shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'PackerUpdate', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' sessions',
                group = 'Number',
                action = 'Telescope session-lens search_session',
                key = 's',
            },
        },
    },
})

-- db.custom_header = {
--     [[]],
--     [[███╗   ███╗ █████╗  ██████╗ ██╗   ██╗ █████╗ ]],
--     [[████╗ ████║██╔══██╗██╔════╝ ██║   ██║██╔══██╗]],
--     [[██╔████╔██║███████║██║  ███╗██║   ██║███████║]],
--     [[██║╚██╔╝██║██╔══██║██║   ██║██║   ██║██╔══██║]],
--     [[██║ ╚═╝ ██║██║  ██║╚██████╔╝╚██████╔╝██║  ██║]],
--     [[╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝]],
--     [[]],
--     [[]],
--     [[                    [麻瓜]                   ]],
--     [[]],
--     [[]],
-- }
