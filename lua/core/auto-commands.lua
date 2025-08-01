local utils = require("utils")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        -- 移除行尾空格
        utils.trim_trailing_whitespace()
        -- fmt
        -- vim.lsp.buf.format({ async = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },

    callback = function()
        -- 打开文件时自动跳转到上次位置
        vim.cmd([[
            if line("'\"") >= 1 && line("'\"") <= line("$")
            \ |   exe "normal! g`\""
            \ | endif
        ]])

        -- remove all the others diagnostics.
        -- for "rachartier/tiny-inline-diagnostic.nvim",
        vim.diagnostic.config({ virtual_text = false })
    end,
})

vim.cmd([[
    augroup _general_settings
    autocmd!
    " outline set keymap
    " or use nvim_set_keymap to set a global keymap
    autocmd FileType lspsagaoutline nnoremap <silent> <buffer> <leader>o  :LSoutlineToggle<CR>
    autocmd TextYankPost * silent!lua require('vim.hl').on_yank({higroup = 'Visual', timeout = 200})
    " 在注释行插入模式下, 回车不要生成新的注释行
    autocmd BufWinEnter * :set formatoptions-=cro
    augroup end

    augroup _git
      autocmd!
      autocmd FileType gitcommit setlocal wrap
      autocmd FileType gitcommit setlocal spell
    augroup end

    augroup _markdown
      autocmd!
      autocmd FileType markdown setlocal wrap
      autocmd FileType markdown setlocal spell
    augroup end

    augroup _auto_resize
      autocmd!
      autocmd VimResized * tabdo wincmd =
    augroup end
]])
