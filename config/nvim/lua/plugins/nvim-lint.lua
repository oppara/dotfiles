local lint = require("lint")

local severities = {
    warning = vim.diagnostic.severity.WARN,
    error = vim.diagnostic.severity.ERROR,
}

local stylelint = lint.linters.stylelint
lint.linters.stylelint = {
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
    stream = stylelint.stream,
    ignore_exitcode = stylelint.ignore_exitcode,
    parser = stylelint.parser,
}

local luacheck = lint.linters.luacheck
lint.linters.luacheck = {
    cmd = "luacheck",
    args = { "--globals", "vim" },
    stdin = true,
    stream = "stdout",
    ignore_exitcode = luacheck.ignore_exitcode,
    parser = luacheck.parser,
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
    css = { "stylelint" },
    scss = { "stylelint" },
    sass = { "stylelint" },
    less = { "stylelint" },
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
