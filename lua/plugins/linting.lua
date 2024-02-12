-- code lint

local function in_py_venv(path)
    if string.find(path, "venv") then
        return true
    else
        return false
    end
end

local function local_mypy_first()
    local python_path = vim.fn.system("which python", true)
    local mypy = "mypy"

    if not in_py_venv(python_path) then
        return mypy
    end

    local parent = string.sub(python_path, 0, -8)
    local local_mypy = parent .. "mypy"
    if vim.fn.filereadable(local_mypy) == 1 then
        return local_mypy
    end

    return mypy
end

local mypy_cmd = function()
    return local_mypy_first()
end

return {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local lint = require("lint")

        local pattern = "([^:]+):(%d+):(%d+): (%a+): (.*)"
        local groups = { "file", "lnum", "col", "severity", "message" }
        local severities = {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            note = vim.diagnostic.severity.HINT,
        }

        lint.linters.mypy_local_first = {
            cmd = mypy_cmd(),
            stdin = false,
            ignore_exitcode = true,
            args = {
                "--show-column-numbers",
                "--hide-error-codes",
                "--hide-error-context",
                "--no-color-output",
                "--no-error-summary",
                "--no-pretty",
            },
            parser = require("lint.parser").from_pattern(
                pattern,
                groups,
                severities,
                { ["source"] = "mypy" }
            ),
        }

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            python = { "mypy_local_first" },
            -- markdown = { "markdownlint" },
            json = { "jsonlint" },
            -- c = { "cpplint" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
            group = lint_augroup,

            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
