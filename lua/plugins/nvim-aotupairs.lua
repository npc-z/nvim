return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")
        local cond = require("nvim-autopairs.conds")

        -- https://github.com/rstacruz/vim-closer/blob/master/autoload/closer.vim
        -- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#expand-multiple-pairs-on-enter-key
        -- Expand multiple pairs on enter key
        local get_closing_for_line = function(line)
            local i = -1
            local clo = ""

            while true do
                i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
                if i == nil then
                    break
                end
                local ch = string.sub(line, i, i)
                local st = string.sub(clo, 1, 1)

                if ch == "{" then
                    clo = "}" .. clo
                elseif ch == "}" then
                    if st ~= "}" then
                        return ""
                    end
                    clo = string.sub(clo, 2)
                elseif ch == "(" then
                    clo = ")" .. clo
                elseif ch == ")" then
                    if st ~= ")" then
                        return ""
                    end
                    clo = string.sub(clo, 2)
                elseif ch == "[" then
                    clo = "]" .. clo
                elseif ch == "]" then
                    if st ~= "]" then
                        return ""
                    end
                    clo = string.sub(clo, 2)
                end
            end

            return clo
        end

        autopairs.setup({
            check_ts = true, -- enable treesitter
            ts_config = {
                lua = { "string" }, -- don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
                java = false, -- don't check treesitter on java
            },
        })

        autopairs.remove_rule("(")
        autopairs.remove_rule("{")
        autopairs.remove_rule("[")

        autopairs.add_rule(Rule("[%(%{%[]", "")
            :use_regex(true)
            :replace_endpair(function(opts)
                return get_closing_for_line(opts.line)
            end)
            :end_wise(function(opts)
                -- Do not endwise if there is no closing
                return get_closing_for_line(opts.line) ~= ""
            end))

        -- import nvim-autopairs completion functionality
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        -- import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")

        -- make autopairs and completion work together
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
