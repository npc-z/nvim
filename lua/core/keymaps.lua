-- vim.api.nvim_set_keymap() 全局快捷键
-- vim.api.nvim_buf_set_keymap() Buffer 快捷键
-- vim.api.nvim_set_keymap('模式', '按键', '映射为', 'options')
-- n Normal 模式
-- i Insert 模式
-- v Visual 模式
-- t Terminal 模式
-- c Command 模式

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- 快速回到 normal mode
map("i", "jj", "<Esc>", opt)
-- map("c", "jj", "<Esc>", opt)
-- map("t", "jj", "<Esc>", opt)

-- buffers
-- map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

-- 快速保存
map("n", "<leader>w", ":w<CR>", opt)
-- map("n", "<leader>wa", ":wa<CR>", opt)
-- quickly input the htree letter `wxx` to save with sudo
vim.keymap.set("c", "wxx", require("utils").sudo_write, { silent = true })
-- or just run below cmd
-- :lua require'utils'.sudo_write()

-- 插入模式下上下左右移动光标
-- map("i", "<C-l>", "<Right>", opt)
-- map("i", "<C-h>", "<Left>", opt)
-- map("i", "<C-k>", "<Up>", opt)
-- map("i", "<C-j>", "<Down>", opt)

-- 跳到行首行尾
map("i", "<C-a>", "<Home>", opt)
map("i", "<C-e>", "<End>", opt)
map("c", "<C-a>", "<home>", {})
map("c", "<C-e>", "<end>", {})

-- 在折行的情况下，移动一个逻辑行
map("n", "j", "gj", opt)
map("n", "k", "gk", opt)

-- map("i", "<C-h>", "<Bs>", opt)
-- map("i", "<C-d>", "<Del>", opt)

map("n", "0", "^", opt)
map("n", "^", "0", opt)
map("n", "<C-e>", "$", opt)
-- 跳转至对应 pair
map("n", "<leader>gp", "%", opt)

-- map("n", "j", "jzz", opt)
-- map("n", "k", "kzz", opt)

-- 选中整个文件
map("n", "vall", "ggVG", opt)
-- 复制整个文件
-- map("n", "ya", "ggVGy<C-o>", opt)

map("n", "<BS>", ":nohl<CR>", opt)

-- 窗口快捷键
-- 取消 s 默认功能
-- map("n", "s", "", opt)
-- 快速分屏
-- map("n", "sv", ":vsp<CR>", opt)
-- map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
-- map("n", "sc", "<C-w>c", opt)
-- 关闭其他
-- map("n", "so", "<C-w>o", opt)

-- Alt + hjkl 创建之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -2<CR>", opt)
map("n", "s.", ":vertical resize +2<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +2<CR>", opt)
map("n", "sk", ":resize -2<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
-- map("n", "<leader>t", ":sp | terminal<CR>", opt)
-- map("n", "<leader>vt", ":vsp | terminal<CR>", opt)

map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- normal 模式中缩进代码
map("n", "<C-[>", "<<", opt)
map("n", "<C-]>", ">>", opt)
-- 因为 <C-[> 默认为行为就是 esc
-- 不加下面这一行的话，导致在 normal 模式中按下 esc 键触发向左缩进
map("n", "<esc>", "<esc>", opt)

-- visual 模式中缩进代码
map("v", "<C-[>", "<gv", opt)
map("v", "<C-]>", ">gv", opt)
map("v", "<esc>", "<esc>", opt)

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
-- map("n", "<C-j>", "4j", opt)
-- map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
-- map("n", "<C-u>", "9k", opt)
-- map("n", "<C-d>", "9j", opt)

-- 在 visual 模式中粘贴不要复制
map("v", "p", "\"_dP", opt)

map("i", "<C-v>", "<C-r>+", opt)

local smart_dd = function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        -- 空白行
        return "\"_dd"
    else
        return "dd"
    end
end
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

-- delete a word backward in insert mode with Ctrl+Backspace
vim.keymap.set("i", "<C-BS>", "<C-w>", opt)
-- to work in command-line mode
vim.api.nvim_set_keymap("!", "<C-BS>", "<C-w>", opt)

-- 退出
map("n", "<leader>q", ":Neotree close<CR>:q<CR>", opt)
-- map("n", "<leader>wq", ":wq<CR>", opt)

-- 编辑相关
map("n", "<leader>uw", "gUiw", opt)
map("n", "<leader>lw", "guiw", opt)
