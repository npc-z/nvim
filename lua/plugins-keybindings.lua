vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opts 参数
local opts = { noremap = true, silent = true }

local opts_with_desc = function(desc)
    return vim.tbl_deep_extend("force", opts, { desc = desc })
end

map("v", "<leader>ws", "<cmd>WordSelectedCount<CR>", opts_with_desc("WordSelectedCount"))

--
-- 插件快捷键绑定
--
local pluginKeys = {}

-- nivm-tree
-- 打开文件树
-- map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>e", ":NeoTreeFocusToggle<CR>", opts)
map("n", "<leader>E", ":NeoTreeFloatToggle<CR>", opts)

-- bufferline
-- 左右Tab切换
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

-- 关闭
map("n", "<C-w>", ":bdelete<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)
map("n", "<leader>bp", ":BufferLineTogglePin<CR>", opts)
map("n", "<leader>bb", ":BufferLinePick<CR>", opts)

-- Telescope
-- 查找文件
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)

-- 全局搜索
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- git branches
map("n", "<leader>fb", ":Telescope git_branches<CR>", opts)

-- work sessions
map("n", "<leader>fs", ":Telescope session-lens search_session<CR>", opts)

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
    i = {
        -- 上下移动
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<Down>"] = "move_selection_next",
        ["<Up>"] = "move_selection_previous",
        -- 历史记录
        ["<C-n>"] = "cycle_history_next",
        ["<C-p>"] = "cycle_history_prev",
        -- 关闭窗口
        ["<C-c>"] = "close",
        -- 预览窗口上下滚动
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",
    },
}

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)

-- hop
-- go to any line
map("n", "<leader>gl", ":HopLine<CR>", opts)
map("n", "ss", ":HopPattern<CR>", opts)
-- 改变 f 的工作方式, 查找当前行所有单字符, 而不仅是光标之后的
map("", "f", ":HopChar1CurrentLine<CR>", opts)
-- map("", "F", ":HopChar1CurrentLineBC<CR>", opt)
-- map("", "t", ":HopChar1CurrentLineAC<CR>", opt)
-- map("", "T", ":HopChar1CurrentLineBC<CR>", opt)

--
-- lsp 回调函数快捷键设置
--
pluginKeys.mapLSP = function(mapbuf)
    -- go xx
    mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    mapbuf("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    -- rename
    mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- code action
    mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- format code
    -- mapbuf("n", "<leader>fc", ":Neoformat<CR>:w<CR>", opts)

    -- 使用 Lspsaga
    local lspsaga_status, _ = pcall(require, "lspsaga")
    if not lspsaga_status then
        vim.notify("没有安装插件: lspsaga")
        return
    end

    -- rename
    mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    -- code action
    mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts_with_desc("code actions"))
    mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts_with_desc("goto definition"))
    mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts_with_desc("show doc in hover"))
    mapbuf("n", "gH", "<cmd>Lspsaga hover_doc ++keep<CR>", opts_with_desc("show doc fixed in right corner"))
    mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)

    -- Call hierarchy
    -- note: 在 desc 中关键字 `call` 会被 which-key(?) 屏蔽
    mapbuf("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts_with_desc("incoming Call hierarchy"))
    mapbuf("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts_with_desc("outgoing Call hierarchy"))
end

return pluginKeys
