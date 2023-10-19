return {
    "mbbill/undotree",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
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
    end,
}
