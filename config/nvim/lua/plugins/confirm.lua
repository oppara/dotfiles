local web_formatter = { "biome", "prettier", "prettierd", stop_after_first = true }

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "phpcbf", "php_cs_fixer", stop_after_first = true },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        javascript = web_formatter,
        typescript = web_formatter,
        javascriptreact = web_formatter,
        typescriptreact = web_formatter,
        css = web_formatter,
        scss = web_formatter,
        sass = web_formatter,
        less = web_formatter,
        markdown = { "markdownlint-cli2" },
        python = { "ruff_format" },
    },

    formatters = {
        shfmt = {
            prepend_args = { "-i", "2", "-ci", "-bn", "-s" },
        },
        yamlfmt = {
            command = "yamlfmt",
            args = { "-" }, -- stdin
            stdin = true,
        },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
