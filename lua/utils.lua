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
    Thursday = "周四",
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

current_week_zh()
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

---get the current buffer file extension
---@type fun():string
local function cur_buf_file_ext()
    local filepath = vim.api.nvim_buf_get_name(0)
    local _, _, ext = split_filename(filepath)
    return ext
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

---@type fun(source: string, pattern: string):boolean
local function contains(source, pattern)
    return string.find(source, pattern) ~= nil
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

-- https://www.reddit.com/r/neovim/comments/p3b20j/lua_solution_to_writing_a_file_using_sudo/
local function sudo_exec(cmd, print_output)
    vim.fn.inputsave()
    local password = vim.fn.inputsecret("Password: ")
    vim.fn.inputrestore()
    if not password or #password == 0 then
        info("Invalid password, sudo aborted")
        return false
    end
    local ok, res = pcall(function()
        return vim.system({
            "sh",
            "-c",
            string.format("echo '%s' | sudo -p '' -S %s", password, cmd),
        }):wait()
    end)
    if not ok or res.code ~= 0 then
        print("\r\n")
        info(not ok and res or res.stderr)
        return false
    end
    if print_output then
        print("\r\n", res.stderr)
    end
    return true
end

local function sudo_write(tmpfile, filepath)
    if not tmpfile then
        tmpfile = vim.fn.tempname()
    end

    if not filepath then
        filepath = vim.fn.expand("%")
    end

    if not filepath or #filepath == 0 then
        info("E32: No file name")
        return
    end

    -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
    -- Both `bs=1M` and `bs=1m` are non-POSIX
    local cmd = string.format(
        "dd if=%s of=%s bs=1048576",
        vim.fn.shellescape(tmpfile),
        vim.fn.shellescape(filepath)
    )

    -- no need to check error as this fails the entire function
    vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })
    if sudo_exec(cmd) then
        -- refreshes the buffer and prints the "written" message
        vim.cmd.checktime()
        -- exit command mode
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "n",
            true
        )
    end
    vim.fn.delete(tmpfile)
end

local function config_diagnostic()
    vim.diagnostic.config({
        virtual_text = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                -- [vim.diagnostic.severity.HINT] = "󰠠 ",
                [vim.diagnostic.severity.HINT] = " ",
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = "Error",
                [vim.diagnostic.severity.WARN] = "Warn",
                [vim.diagnostic.severity.INFO] = "Info",
                [vim.diagnostic.severity.HINT] = "Hint",
            },
        },
    })
end

local funcs = {}

funcs.trim_trailing_whitespace = trim_trailing_whitespace
funcs.current_week_zh = current_week_zh
funcs.split_filename = split_filename
funcs.cur_buf_filename = cur_buf_filename
funcs.cur_buf_file_ext = cur_buf_file_ext
funcs.require_fail_and_continue = require_fail_and_continue
funcs.has_value = has_value
funcs.contains = contains
funcs.log = log
funcs.sudo_write = sudo_write
funcs.config_diagnostic = config_diagnostic

return funcs
