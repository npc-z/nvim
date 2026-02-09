local function add_snippets()
    local utils = require("utils")
    local ls = require("luasnip")
    local s = ls.snippet
    local f = ls.function_node
    -- local sn = ls.snippet_node
    -- local isn = ls.indent_snippet_node
    -- local t = ls.text_node
    -- local i = ls.insert_node
    -- local c = ls.choice_node
    -- local d = ls.dynamic_node
    -- local r = ls.restore_node
    -- local events = require("luasnip.util.events")
    -- local ai = require("luasnip.nodes.absolute_indexer")
    -- local extras = require("luasnip.extras")
    -- local fmt = extras.fmt
    -- local m = extras.m
    -- local l = extras.l
    -- local postfix = require("luasnip.extras.postfix").postfix

    ls.add_snippets("all", {
        -- 周X
        s("week", {
            f(function()
                return utils.current_week_zh()
            end),
        }),
    })
end

return {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- optional: provides snippets for the snippet source
        "rafamadriz/friendly-snippets",

        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        -- Dictionary source for blink.cmp
        -- "Kaiser-Yang/blink-cmp-dictionary",
        "archie-judd/blink-cmp-words",

        "onsails/lspkind.nvim", -- vs-code like pictograms

        {
            "giuxtaposition/blink-cmp-copilot",
        },
    },
    config = function()
        local opts = {
            keymap = {
                -- 'none' for no mappings
                preset = "none",

                -- 触发补全
                ["<C-.>"] = { "show", "show_documentation", "hide_documentation" },
                -- 取消
                ["<C-e>"] = { "hide", "fallback" },
                -- 确认
                ["<CR>"] = { "select_and_accept", "fallback" },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
                ["<C-j>"] = { "select_next", "fallback_to_mappings" },

                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },

                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },

            snippets = { preset = "luasnip" },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                    "dictionary",
                    "copilot",
                },

                providers = {
                    path = {
                        module = "blink.cmp.sources.path",
                        score_offset = 3,
                        fallbacks = { "buffer" },
                        opts = {
                            trailing_slash = true,
                            label_trailing_slash = true,
                            get_cwd = function(context)
                                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                            end,
                            show_hidden_files_by_default = true,
                            -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
                            ignore_root_slash = false,
                        },
                    },

                    -- Use the dictionary source
                    dictionary = {
                        name = "directory",
                        module = "blink-cmp-words.dictionary",
                        -- All available options
                        opts = {
                            -- The number of characters required to trigger completion.
                            -- Set this higher if completion is slow, 3 is default.
                            dictionary_search_threshold = 2,

                            -- See above
                            score_offset = 0,

                            -- See above
                            definition_pointers = { "!", "&", "^" },
                        },
                    },
                    -- use copilot
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                        transform_items = function(_, items)
                            local CompletionItemKind =
                                require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                    },
                },
            },

            -- Experimental signature help support
            signature = {
                enabled = true,
                trigger = {
                    -- Show the signature help automatically
                    enabled = true,
                },
            },

            appearance = {
                nerd_font_variant = "mono",
                kind_icons = {
                    Copilot = "",
                },
            },

            completion = {
                documentation = {
                    auto_show = true,
                },

                accept = {
                    auto_brackets = {
                        -- Whether to auto-insert brackets for functions
                        enabled = true,
                        -- Default brackets to use for unknown languages
                        default_brackets = { "(", ")" },
                    },
                },

                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },

                -- ghost_text = {
                --     enabled = true,
                -- },

                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if
                                        vim.tbl_contains({ "Path" }, ctx.source_name)
                                    then
                                        local dev_icon, _ =
                                            require("nvim-web-devicons").get_icon(
                                                ctx.label
                                            )
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                    end

                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if
                                        vim.tbl_contains({ "Path" }, ctx.source_name)
                                    then
                                        local dev_icon, dev_hl =
                                            require("nvim-web-devicons").get_icon(
                                                ctx.label
                                            )
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },
                        },
                    },
                },
            },

            cmdline = {
                keymap = {
                    preset = "inherit",
                    ["<CR>"] = { "select_accept_and_enter", "fallback" },
                },
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        }

        local cmp = require("blink.cmp")
        cmp.setup(opts)

        add_snippets()
        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
