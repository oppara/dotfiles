local lint = require("lint")

local severities = {
    warning = vim.diagnostic.severity.WARN,
    error = vim.diagnostic.severity.ERROR,
}

lint.linters.stylelint_with_npx = {
    cmd = "npx",
    args = {
        "stylelint",
        "-f",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
            return vim.fn.expand("%:p")
        end,
    },
    stdin = true,
    stream = "both",
    ignore_exitcode = true,
    parser = function(output)
        local status, decoded = pcall(vim.json.decode, output)
        if status then
            decoded = decoded[1]
        else
            decoded = {
                warnings = {
                    {
                        line = 1,
                        column = 1,
                        text = "Stylelint error, run `stylelint " .. vim.fn.expand("%") .. "` for more info.",
                        severity = "error",
                        rule = "none",
                    },
                },
                errored = true,
            }
        end
        local diagnostics = {}
        if decoded.errored then
            for _, message in ipairs(decoded.warnings) do
                table.insert(diagnostics, {
                    lnum = message.line - 1,
                    col = message.column - 1,
                    end_lnum = message.line - 1,
                    end_col = message.column - 1,
                    message = message.text,
                    code = message.rule,
                    user_data = {
                        lsp = {
                            code = message.rule,
                        },
                    },
                    severity = severities[message.severity],
                    source = "stylelint",
                })
            end
        end
        return diagnostics
    end,
}

lint.linters_by_ft = {
    lua = { "luacheck" },
    sh = { "shellcheck" },
    yaml = { "yamllint" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    json = { "jsonlint" },
    css = { "stylelint_with_npx" },
    scss = { "stylelint_with_npx" },
    sass = { "stylelint_with_npx" },
    less = { "stylelint_with_npx" },
    markdown = { "markdownlint-cli2" },
    python = { "ruff", "flake8" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = ".github/workflows/*.yml",
    callback = function()
        lint.linters_by_ft.yaml = { "yamllint", "actionlint" }
    end,
})
