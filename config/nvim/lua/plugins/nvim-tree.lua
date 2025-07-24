vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimTreeFocusOrToggle = function()
    local nvimTree = require("nvim-tree.api")
    local currentBuf = vim.api.nvim_get_current_buf()
    local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
    if currentBufFt == "NvimTree" then
        nvimTree.tree.toggle()
    else
        nvimTree.tree.focus()
    end
end
vim.keymap.set("n", "<leader>e", nvimTreeFocusOrToggle, { noremap = true, silent = true })

local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    local function change_root_to_node(node)
        if node == nil then
            node = api.tree.get_node_under_cursor()
        end

        if node ~= nil and node.type == "directory" then
            vim.api.nvim_set_current_dir(node.absolute_path)
        end
        api.tree.change_root_to_node(node)
    end

    local function change_root_to_parent(node)
        local abs_path
        if node == nil then
            abs_path = api.tree.get_nodes().absolute_path
        else
            abs_path = node.absolute_path
        end

        local parent_path = vim.fs.dirname(abs_path)
        vim.api.nvim_set_current_dir(parent_path)
        api.tree.change_root(parent_path)
    end

    vim.keymap.set("n", "l", change_root_to_node, opts("CD"))
    vim.keymap.set("n", "h", change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
    vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))

    local preview = require("nvim-tree-preview")
    vim.keymap.set("n", "p", preview.watch, opts("Preview (Watch)"))
    vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))
    vim.keymap.set("n", "<C-f>", function()
        return preview.scroll(4)
    end, opts("Scroll Down"))
    vim.keymap.set("n", "<C-b>", function()
        return preview.scroll(-4)
    end, opts("Scroll Up"))
end

require("nvim-tree").setup({
    sort_by = "extension",
    respect_buf_cwd = true,

    update_focused_file = {
        enable = true,
        update_cwd = true,
    },

    view = {
        width = "20%",
        side = "left",
        signcolumn = "no",
    },

    git = {
        enable = true,
        ignore = false,
    },

    renderer = {
        highlight_git = "all",
        highlight_opened_files = "all",
        icons = {
            glyphs = {
                git = {
                    unstaged = "!",
                    renamed = "»",
                    untracked = "?",
                    deleted = "✘",
                    staged = "✓",
                    unmerged = "",
                    ignored = "◌",
                },
            },
        },
    },

    diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        icons = {
            hint = " ",
            info = " ",
            warning = " ",
            error = " ",
        },
    },

    actions = {
        expand_all = {
            max_folder_discovery = 100,
            exclude = { ".git" },
        },
        open_file = {
            quit_on_open = true,
        },
    },

    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "?", api.tree.toggle_help, { buffer = bufnr, noremap = true, silent = true, nowait = true })
        nvim_tree_on_attach(bufnr)
    end,
})
