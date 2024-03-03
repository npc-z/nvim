-- vim.g.{name}: 全局变量
-- vim.b.{name}: 缓冲区变量
-- vim.w.{name}: 窗口变量
-- vim.bo.{option}: buffer-local 选项
-- vim.wo.{option}: window-local 选项

-- install gvim and set this
vim.o.clipboard = "unnamedplus"

-- utf-8
vim.g.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- jkhl 移动时光标周围保留 8 行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true

-- 高亮所在行
vim.wo.cursorline = true

-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"

-- 右侧参考线
vim.wo.colorcolumn = "88"

-- 缩进 4 个空格
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.shiftround = 4
-- >> << 时移动长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- 空格代替 tab
vim.o.expandtab = true
vim.bo.expandtab = true

-- 缩进
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 边输入边搜索
vim.o.incsearch = true

-- 搜索大小写不敏感, 除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 命令行高为 0
-- use noice
vim.o.cmdheight = 0

-- 当文件被外部程序修改时, 自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 禁止折行
vim.wo.wrap = false

-- 光标在行首/行尾时 <Left> <Right> 可以跳到下一行
vim.o.whichwrap = "<,>,[,]"

-- 允许隐藏被修改过的 buffer
vim.o.hidden = true

-- 鼠标支持
vim.o.mouse = "a"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- smaller updatetime
vim.o.updatetime = 500

-- 设置等待键盘快捷键连击时间, 毫秒
vim.o.timeoutlen = 500

-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 自动补全, 不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 补全增强
vim.o.wildmenu = true
-- don't pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"
-- 补全最多显示 10 行
vim.o.pumheight = 10

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- 显出不可见字符
vim.o.list = true
vim.opt.listchars = {
    -- space = "·",
    -- tab = "⇥ ",
    tab = "│ ",
    trail = "·",
    nbsp = "·",
    -- leadmultispace = "┊ ",
    -- eol = "↵",
    -- trail = "␣",
    -- nbsp = "⍽",
}

-- 显示 tabline
vim.o.showtabline = 2

vim.cmd([[set iskeyword+=-]])

-- 使用增强状态栏插件后不再需要 vim 的显示提示
-- vim.o.showmode = false

-- 保存 undotree 到本地文件
vim.cmd([[
    if has("persistent_undo")
       let target_path = expand("~/.local/share/nvim/undodir")
            if !isdirectory(target_path)
                call mkdir(target_path, "p", 0700)
            endif

        let &undodir=target_path
        set undofile
    endif
]])
