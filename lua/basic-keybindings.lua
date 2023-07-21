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

-- 快速保存
map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wa", ":wa<CR>", opt)

-- 插入模式下上下左右移动光标
map("i", "<C-f>", "<Right>", opt)
map("i", "<C-b>", "<Left>", opt)
map("i", "<C-k>", "<Up>", opt)
map("i", "<C-j>", "<Down>", opt)

-- 跳到行首行尾
map("i", "<C-a>", "<Esc>I", opt)
map("i", "<C-e>", "<Esc>A", opt)
map("i", "<C-h>", "<Bs>", opt)
map("i", "<C-d>", "<Del>", opt)

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

-- 窗口快捷键
-- 取消 s 默认功能
map("n", "s", "", opt)
-- 快速分屏
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl 创建之间跳转
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

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

-- visual 模式中缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
-- map("n", "<C-j>", "4j", opt)
-- map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 在 visual 模式中粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "<leader>q", ":q<CR>", opt)
map("n", "<leader>wq", ":wq<CR>", opt)

-- 编辑相关
map("n", "<leader>uw", "gUiw", opt)
map("n", "<leader>lw", "guiw", opt)
