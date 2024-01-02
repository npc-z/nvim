-- 封装删除行的 Lua 函数
function DeleteLinesWithKeyword(keyword)
    -- 默认关键字为 'del'
    keyword = keyword or "del"

    -- 获取所有包含关键字的行号
    local to_be_deleted_lines = vim.fn.filter(
        vim.fn.range(1, vim.fn.line("$") - 1),
        function(line_number)
            local line_content = vim.fn.getline(line_number)
            return vim.fn.match(line_content, keyword) > -1
        end
    )

    -- 倒序删除包含关键字的每一行（除了最后一行）
    for i = #to_be_deleted_lines, 1, -1 do
        vim.fn.deletebufline("%", to_be_deleted_lines[i])
    end

    -- 输出删除的行数
    print("Deleted " .. #to_be_deleted_lines .. " lines with '" .. keyword .. "'.")
end

-- 创建 Neovim 用户自定义命令
vim.cmd("command! -nargs=? Fuck lua DeleteLinesWithKeyword(<f-args>)")
