local status, comment = pcall(require, "Comment")
if not status then
    vim.notify("没有找到 Comment")
    return
end

local opts = {
    -- Add a space b/w comment and the line
    -- @type boolean|fun():boolean
    padding = true,

    -- Whether the cursor should stay at its position
    -- NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    -- @type boolean
    sticky = true,

    -- Lines to be ignored while comment/uncomment.
    -- Could be a regex string or a function that returns a regex string.
    -- Example: Use '^$' to ignore empty lines
    -- @type string|fun():string
    ignore = nil,

    -- LHS of toggle mappings in NORMAL + VISUAL mode
    -- @type table
    toggler = {
        ---Line-comment toggle keymap
        -- For some reason, vim registers <C-/> as <C-_> (you can see it in insert mode using <C-v><C-/>).
        -- It can be the terminal or a historical design thing that terminal apps have to suffer.
        -- And Gvim doesn't even try to recognize <C-/>. Sees it as single /.
        -- line = "<C-_>",
        -- line = "<leader>/",
        line = "gcc",
        -- Block-comment toggle keymap
        block = "gbc",
    },

    -- LHS of operator-pending mappings in NORMAL + VISUAL mode
    -- @type table
    opleader = {
        ---Line-comment keymap
        line = "gc",
        ---Block-comment keymap
        block = "gb",
    },

    -- LHS of extra mappings
    -- @type table
    extra = {
        ---Add comment on the line above
        -- above = "gcO",
        ---Add comment on the line below
        -- below = "gco",
        ---Add comment at the end of line
        -- eol = "gcA",
    },

    -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    -- NOTE: If `mappings = false` then the plugin won't create any mappings
    -- @type boolean|table
    mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = false,
        ---Extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
    },

    ---Pre-hook, called before commenting the line
    ---@type fun(ctx: Ctx):string
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type fun(ctx: Ctx)
    post_hook = nil,
}

-- 关闭了 extra 快捷键，只用 keybindings 里定义的基础快捷键
comment.setup(opts)

function _G.__toggle_contextual(vmode)
    local cfg = require('Comment.config'):get()
    local U = require('Comment.utils')
    local Op = require('Comment.opfunc')
    local range = U.get_region(vmode)
    local same_line = range.srow == range.erow

    local ctx = {
        cmode = U.cmode.toggle,
        range = range,
        cmotion = U.cmotion[vmode] or U.cmotion.line,
        ctype = same_line and U.ctype.linewise or U.ctype.blockwise,
    }

    local lcs, rcs = U.parse_cstr(cfg, ctx)
    local lines = U.get_lines(range)

    local params = {
        range = range,
        lines = lines,
        cfg = cfg,
        cmode = ctx.cmode,
        lcs = lcs,
        rcs = rcs,
    }

    if same_line then
        Op.linewise(params)
    else
        Op.blockwise(params)
    end
end

local map = vim.api.nvim_set_keymap

local opt = { noremap = true, silent = true }

-- map("n", "<leader>/", "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@$", opt)
map("n", "<C-\\>", "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@$", opt)
-- map("x", "<leader>/", "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@", opt)
map("x", "<C-\\>", "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@", opt)
