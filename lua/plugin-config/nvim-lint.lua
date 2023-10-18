local status, lint = pcall(require, "lint")
if not status then
    vim.notify("没有安装插件: lint")
    return
end

lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    python = { "mypy" },
    markdown = { "markdownlint" },
    json = { "jsonlint" },
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
