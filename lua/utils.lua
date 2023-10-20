-- 自定义工具函数

local notify_ok, notify = pcall(require, "notify")
-- log
local function log(body)
    if notify_ok then
        notify(body, "info", { title = "log info" })
    else
        vim.notify(body)
    end
end

-- info
local function info(body)
    if notify_ok then
        notify(body, "info", { title = "info" })
    else
        vim.notify(body)
    end
end

local daysoftheweek = {
    Sunday = "周日",
    Monday = "周一",
    Tuesday = "周二",
    Wednesday = "周三",
    Thrusday = "周四",
    Friday = "周五",
    Saturday = "周六",
}

local function current_week_zh()
    local week = os.date("%A")
    for k, v in pairs(daysoftheweek) do
        if k == week then
            return v
        end
    end
    return week
end
---@type fun(filepath: string)
local function require_fail_and_continue(path)
    local status_ok, _ = pcall(require, path)
    if not status_ok then
        local msg = "requile module " .. path .. " failed"
        info(msg)
    end
end

---@type fun(filepath: string):string, string, string
local function split_filename(filepath)
    -- Returns the Path, Filename, and Extension as 3 values
    return string.match(filepath, "(.-)([^/]-([^/%.]+))$")
end

---get the current buffer filename
---@type fun():string
local function cur_buf_filename()
    local filepath = vim.api.nvim_buf_get_name(0)
    local _, name, _ = split_filename(filepath)
    return name
end

---get the current buffer filename
---@type fun():string
local function cur_buf_filetype()
    local filepath = vim.api.nvim_buf_get_name(0)
    local _, _, type = split_filename(filepath)
    return type
end

---@type fun(tab: table, val: string):boolean
local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- 移除行尾的空格
local function trim_trailing_whitespace()
    -- 排除文件类型
    local excludes = {
        "markdown",
    }
    if has_value(excludes, vim.bo.filetype) then
        return
    end
    vim.cmd([[%s/\s\+$//e]])
end

local funcs = {}

funcs.trim_trailing_whitespace = trim_trailing_whitespace
funcs.current_week_zh = current_week_zh
funcs.split_filename = split_filename
funcs.cur_buf_filename = cur_buf_filename
funcs.cur_buf_filetype = cur_buf_filetype
funcs.require_fail_and_continue = require_fail_and_continue
funcs.has_value = has_value
funcs.log = log

return funcs
