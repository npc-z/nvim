vim.cmd([[
    " enable this plugin for filetypes, '*' for all files.
    " let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}
    let g:apc_enable_ft = { "*": 1 }

    " source for dictionary, current or other loaded buffers, see ':help cpt'
    set cpt=.,k,w,b

    " suppress annoy messages.
    " set shortmess+=c

    " don't select the first item.
    set completeopt=menu,menuone,noselect

    " File type override
    " 这里都加上单词补全
    let g:vim_dict_config = {
        \ "lua": "lua,text",
        \ "vim": "vim,text",
        \ "go": "go,text",
        \ "python": "python,text",
        \ "c": "c,text",
    \ }
]])
