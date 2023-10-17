local function use_theme(theme_name)
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. theme_name)
    if not status_ok then
        vim.notify("colorscheme: " .. theme_name .. " 没有找到!")
        return false
    end

    return true
end

local function use_and_setup_tokyonight()
    local colorscheme = "tokyonight"

    local plugin_ok, plugin = pcall(require, colorscheme)
    if not plugin_ok then
        vim.notify("未安装主题: " .. colorscheme)
        return false
    end

    -- setup
    plugin.setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark",            -- style for sidebars, see below
            floats = "dark",              -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        on_highlights = function(highlights, colors) end,
    })

    return use_theme(colorscheme)
end

local function use_and_setup_onedark()
    local colorscheme = "onedark"

    return use_theme(colorscheme)
end


local function use_and_setup_gruvbox()
    local colorscheme = "gruvbox"

    vim.cmd("set background=dark") -- or light if you want light mode

    return use_theme(colorscheme)
end

local function use_and_setup_kanagawa()
    local colorscheme = "kanagawa"

    vim.cmd("set background=dark") -- or light if you want light mode

    return use_theme(colorscheme)
end

local themes = {}
themes.tokyonight = use_and_setup_tokyonight
themes.kanagawa = use_and_setup_kanagawa
-- themes.onedark = use_and_setup_onedark
-- themes.gruvbox = use_and_setup_gruvbox

local _themes = {
    "tokyonight",
    "kanagawa",
    -- "onedark",
    -- "gruvbox",
}
local selected_theme = _themes[2]

local status_ok = themes[selected_theme]()

if not status_ok then
    vim.notify("set colorscheme: " .. selected_theme .. " failed.")
    vim.cmd("colorscheme desert")
    vim.notify("use colorscheme desert")
    return
end

-- vim.notify("use colorscheme " .. selected_theme)
