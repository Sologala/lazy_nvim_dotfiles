return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        auto_reload_on_write = true,
        view = {
            adaptive_size = false,
            centralize_selection = false,
            width = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
        },

        on_attach = function(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Up'))
            vim.keymap.set('n', 'l', api.node.open.edit, opts('Help'))
            vim.keymap.set('n', 'D', api.tree.toggle_gitignore_filter, opts('Toggle git ignore file'))
            -- custom mappings
            --vim.keymap.set('n', 'h', api.tree.close_node, opts('Close'))
            --vim.keymap.set('n', 'l', api.node.navigate.parent_close, opts('Close Parent'))
        end
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
}
