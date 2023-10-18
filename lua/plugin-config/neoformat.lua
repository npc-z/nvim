vim.cmd([[

let g:neoformat_try_formatprg = 1
let g:neoformat_try_node_exe = 1


" Enable alignment
let g:neoformat_basic_format_align = 1


" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1


" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1


" Python
let g:neoformat_enabled_python = ["black"]


" Lua
let g:neoformat_enabled_lua = ["stylua"]


" Go
let g:neoformat_enabled_go = ["gofmt"]


" Cpp
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_cpp_clangformat = {
\ 'exe': 'clang-format',
\ 'args': ['--style="{IndentWidth: 4}"']
\ }


" C
let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_c_clangformat = {
\ 'exe': 'clang-format',
\ 'args': ['--style="{IndentWidth: 4}"']
\ }


]])
