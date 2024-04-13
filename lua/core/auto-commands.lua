local utils = require("utils")

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    desc = "Auto select virtualenv Nvim open",
    pattern = "*",
    once = true,
    callback = function()
        require("venv-selector").retrieve_from_cache()
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        -- 移除行尾空格
        utils.trim_trailing_whitespace()
        -- fmt
        -- vim.lsp.buf.format({ aysnc = true })
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

        -- 为 .conf 文件设置 filetype, for plugin Comment
        local ext = utils.cur_buf_file_ext()
        if ext == "conf" then
            vim.cmd([[ set ft=conf ]])
        end
    end,
})

vim.cmd([[
    augroup _general_settings
    autocmd!
    " outline set keymap
    " or use nvim_set_keymap to set a global keymap
    autocmd FileType lspsagaoutline nnoremap <silent> <buffer> <leader>o  :LSoutlineToggle<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
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
