local status, ident_blankline = pcall(require, "lazygit")
if not status then
    vim.notify("没有安装插件: lazygit")
    return
end

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "<leader>lg", ":LazyGit<CR>", opt)
