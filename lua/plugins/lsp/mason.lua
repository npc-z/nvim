return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        local ensure_installed_lsp_servers = {
            "ts_ls",
            "html",
            "cssls",
            "tailwindcss",
            -- "lua_ls",
            "pyright",
            "gopls",
            "rust_analyzer",
            -- "nil_ls",
            "sqls",
        }

        local ensure_installed_tools = {
            "clang-format",
            "prettier", -- prettier formatter
            -- "stylua", -- lua formatter
            "isort", -- python formatter
            "black", -- python formatter
            "mypy", -- python linter
            "eslint_d", -- js linter
            "markdownlint",
            "jsonlint",
            "sqlfluff",
            "codelldb",
        }

        local handle = io.popen("uname -a")
        if handle ~= nil then
            local u = require("utils")
            local os_name = handle:read("*a")
            handle:close()

            local is_nixos = u.contains(os_name, "nixos")
            if is_nixos then
                -- 当系统为 nixos 时才安装 nil_ls
                table.insert(ensure_installed_lsp_servers, "nil_ls")
            else
                -- 当系统非 nixos 时才安装 lua_ls / stylua
                table.insert(ensure_installed_lsp_servers, "lua_ls")
                table.insert(ensure_installed_tools, "stylua")
            end
        end

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = ensure_installed_lsp_servers,
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        mason_tool_installer.setup({
            ensure_installed = ensure_installed_tools,
        })
    end,
}
