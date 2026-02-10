-- Enhanced Grep 功能模块
-- 提供增强的搜索功能，支持参数化搜索和路径模糊匹配

local M = {}

-- 路径模糊匹配函数
local function find_matching_directories(pattern, cwd)
    if not pattern or pattern == "" then
        return {}
    end

    -- 如果路径存在，直接返回
    local full_path = cwd .. "/" .. pattern
    if vim.fn.isdirectory(full_path) == 1 then
        return { pattern }
    end

    -- 如果是绝对路径，直接返回
    if pattern:match("^/") or pattern:match("^~") then
        local expanded = vim.fn.expand(pattern)
        if vim.fn.isdirectory(expanded) == 1 then
            return { expanded }
        end
        return {}
    end

    -- 使用 fd 或 find 查找匹配的目录
    local matches = {}
    local cmd

    -- 提取路径的最后一部分用于模糊搜索
    local search_term = pattern:match("([^/]+)$") or pattern

    -- 尝试使用 fd (更快)
    if vim.fn.executable("fd") == 1 then
        -- 先尝试精确匹配完整路径
        cmd = string.format(
            "fd --type d --hidden --exclude .git --exclude node_modules --max-depth 5 --full-path '%s' '%s' 2>/dev/null",
            pattern,
            cwd
        )

        local handle = io.popen(cmd)
        if handle then
            for line in handle:lines() do
                local relative = line:gsub("^" .. vim.pesc(cwd) .. "/", "")
                    :gsub("/$", "")
                if relative ~= "" then
                    table.insert(matches, relative)
                end
            end
            handle:close()
        end

        -- 如果没有精确匹配，尝试模糊匹配
        if #matches == 0 then
            cmd = string.format(
                "fd --type d --hidden --exclude .git --exclude node_modules --max-depth 5 '%s' '%s' 2>/dev/null",
                search_term,
                cwd
            )

            handle = io.popen(cmd)
            if handle then
                for line in handle:lines() do
                    local relative = line:gsub("^" .. vim.pesc(cwd) .. "/", "")
                        :gsub("/$", "")
                    if relative ~= "" then
                        table.insert(matches, relative)
                    end
                end
                handle:close()
            end
        end
    else
        -- 回退到 find
        cmd = string.format(
            "find '%s' -type d \\( -name '*%s*' -o -path '*%s*' \\) -not -path '*/.git/*' -not -path '*/node_modules/*' 2>/dev/null | head -20",
            cwd,
            search_term,
            pattern
        )

        local handle = io.popen(cmd)
        if handle then
            for line in handle:lines() do
                local relative = line:gsub("^" .. vim.pesc(cwd) .. "/", "")
                    :gsub("/$", "")
                if relative ~= "" then
                    table.insert(matches, relative)
                end
            end
            handle:close()
        end
    end

    return matches
end

-- 解析搜索参数（搜索词在前，参数在后）
local function parse_args(prompt)
    local args = {
        search_term = "",
        file_types = {},
        directories = {},
        word_match = false,
        case_sensitive = false,
        hidden = false,
    }

    if not prompt or prompt == "" then
        return args
    end

    local parts = {}
    for part in prompt:gmatch("%S+") do
        table.insert(parts, part)
    end

    if #parts == 0 then
        return args
    end

    local search_parts = {}
    local i = 1

    -- 首先收集搜索词（直到遇到第一个 - 开头的参数）
    while i <= #parts do
        local part = parts[i]

        if part:match("^%-") then
            -- 遇到参数标志，停止收集搜索词
            break
        else
            table.insert(search_parts, part)
            i = i + 1
        end
    end

    args.search_term = table.concat(search_parts, " ")

    -- 如果没有搜索词但有参数，可能用户还在输入中
    if args.search_term == "" and i <= #parts then
        return args
    end

    -- 然后解析后面的参数标志
    while i <= #parts do
        local part = parts[i]

        if part == "-t" or part == "--type" then
            i = i + 1
            if i <= #parts and not parts[i]:match("^%-") then
                table.insert(args.file_types, parts[i])
            else
                i = i - 1
            end
        elseif part == "-d" or part == "--dir" then
            i = i + 1
            if i <= #parts and not parts[i]:match("^%-") then
                table.insert(args.directories, parts[i])
            else
                i = i - 1
            end
        elseif part == "-w" or part == "--word" then
            args.word_match = true
        elseif part == "-s" or part == "--case-sensitive" then
            args.case_sensitive = true
        elseif part == "-h" or part == "--hidden" then
            args.hidden = true
        end

        i = i + 1
    end

    return args
end

-- 解析和展开目录路径
local function resolve_directories(dir_patterns, cwd)
    local resolved = {}

    for _, pattern in ipairs(dir_patterns) do
        local matches = find_matching_directories(pattern, cwd)

        if #matches == 0 then
            -- 没有匹配，使用原始路径
            table.insert(resolved, pattern)
        elseif #matches == 1 then
            -- 单个匹配，使用它
            table.insert(resolved, matches[1])
        else
            -- 多个匹配，使用第一个（最佳匹配）
            table.insert(resolved, matches[1])

            -- 显示找到多个匹配的提示
            if #matches > 1 then
                vim.schedule(function()
                    local msg = string.format(
                        "Path '%s' matched %d directories, using: %s\nOther matches: %s",
                        pattern,
                        #matches,
                        matches[1],
                        table.concat(
                            vim.list_slice(matches, 2, math.min(#matches, 4)),
                            ", "
                        )
                    )
                    vim.notify(msg, vim.log.levels.INFO)
                end)
            end
        end
    end

    return resolved
end

-- 构建 ripgrep 命令参数
local function build_rg_args(parsed_args)
    local rg_args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
    }

    -- 大小写处理
    if parsed_args.case_sensitive then
        table.insert(rg_args, "--case-sensitive")
    else
        table.insert(rg_args, "--smart-case")
    end

    -- 全字匹配
    if parsed_args.word_match then
        table.insert(rg_args, "--word-regexp")
    end

    -- 隐藏文件
    if parsed_args.hidden then
        table.insert(rg_args, "--hidden")
    end

    -- 文件类型
    for _, ftype in ipairs(parsed_args.file_types) do
        table.insert(rg_args, "--type=" .. ftype)
    end

    -- 排除规则
    local exclude_patterns = {
        "**/.git/*",
        "**/.idea/*",
        "**/.vscode/*",
        "**/build/*",
        "**/dist/*",
        "**/node_modules/*",
        "**/yarn.lock",
        "**/package-lock.json",
    }

    for _, pattern in ipairs(exclude_patterns) do
        table.insert(rg_args, "--glob=!" .. pattern)
    end

    return rg_args
end

-- 显示帮助信息
local function show_help()
    local help_text = [[
Enhanced Grep - 使用说明:

用法: <搜索词> [参数]

参数:
  -t, --type <TYPE>        指定文件类型 (例如: -t lua)
  -d, --dir <DIR>          指定搜索目录 (支持模糊匹配)
  -w, --word               全字匹配
  -s, --case-sensitive     大小写敏感搜索
  -h, --hidden             包含隐藏文件

基础搜索:
  function                # 搜索 "function"
  rust                    # 搜索 "rust"
  my search term          # 搜索 "my search term"

添加参数 (参数在搜索词后面):
  rust -w                 # 全字匹配 "rust"
  function -t lua         # 只在 lua 文件中搜索 "function"
  config -t lua -t py     # 在 lua 和 python 文件中搜索 "config"
  test -w -t lua          # 在 lua 文件中全字匹配 "test"
  MyClass -s              # 大小写敏感搜索 "MyClass"

路径模糊匹配:
  function -d plugins     # 在 plugins 目录中搜索 (自动匹配 lua/plugins)
  require -d lsp          # 在 lsp 目录中搜索 (自动匹配 lua/plugins/lsp)
  config -d lua/plugins   # 使用完整路径
  func -d core -d plugins # 在多个目录中搜索

组合使用:
  test -d plugins -t lua -w     # 在 plugins 的 lua 文件中全字匹配 "test"
  config -d lsp -w -s           # 在 lsp 目录中大小写敏感全字匹配 "config"

常用文件类型:
  lua, py, js, ts, jsx, tsx, go, rust, c, cpp, java, md, txt, json, yaml

提示:
  - 搜索词必须在前面，参数在后面
  - 路径支持模糊匹配，会自动查找匹配的目录
  - 输入 '?' 或 'help' 显示此帮助
]]
    vim.notify(help_text, vim.log.levels.INFO)
end

-- 创建增强版的 live_grep 函数
function M.create_enhanced_grep(opts)
    opts = opts or {}

    -- 设置 cwd
    local utils = require("telescope.utils")
    opts.cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.loop.cwd()

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")
    local sorters = require("telescope.sorters")

    -- 创建自定义 picker
    pickers
        .new(opts, {
            prompt_title = "Enhanced Grep (? for help)",
            finder = finders.new_job(function(prompt)
                if not prompt or prompt == "" then
                    return nil
                end

                -- 检查是否是帮助命令
                if prompt == "?" or prompt == "help" then
                    show_help()
                    return nil
                end

                local parsed_args = parse_args(prompt)

                if parsed_args.search_term == "" then
                    return nil
                end

                -- 解析和展开目录路径
                local resolved_dirs =
                    resolve_directories(parsed_args.directories, opts.cwd)

                local rg_args = build_rg_args(parsed_args)

                -- 添加搜索词
                table.insert(rg_args, "--")
                table.insert(rg_args, parsed_args.search_term)

                -- 添加目录（如果指定）
                if #resolved_dirs > 0 then
                    for _, dir in ipairs(resolved_dirs) do
                        table.insert(rg_args, dir)
                    end
                else
                    table.insert(rg_args, ".")
                end

                return vim.tbl_flatten({ "rg", rg_args })
            end, make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd),
            previewer = conf.grep_previewer(opts),
            sorter = sorters.highlighter_only(opts),
        })
        :find()
end

return M
