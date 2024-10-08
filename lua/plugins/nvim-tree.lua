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
        renderer = {
            -- 不显示root_folder
            add_trailing = false,
            group_empty = true,
            full_name = false,
            root_folder_label = ":~:s?$?/..?",
            indent_width = 2,
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
            highlight_git = "none",
            highlight_diagnostics = "none",
            highlight_opened_files = "none",
            highlight_modified = "none",
            highlight_bookmarks = "none",
            highlight_clipboard = "name",
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
            icons = {
                web_devicons = {
                    file = {
                        enable = true,
                        color = true,
                    },
                    folder = {
                        enable = false,
                        color = true,
                    },
                },
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                    modified = true,
                    diagnostics = true,
                    bookmarks = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "󰆤",
                    modified = "●",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },

        },
        actions = {
            open_file = {
                quit_on_open = true
            }
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
            vim.keymap.set('n', '[g', api.node.navigate.git.prev, opts('Prev Git'))
            vim.keymap.set('n', 'N', function()
                local node = api.tree.get_node_under_cursor()
                print(node.absolute_path)
                if node then
                    print("nautilus " .. node.absolute_path)
                    vim.fn.jobstart("nautilus " .. node.absolute_path, { detach = true })
                end
            end, opts('Nautilus'))
            -- vim.keymap.set('n', 'O, api.node.navigate.git.next, opts('Next Git'))
            -- custom mappings
            --vim.keymap.set('n', 'h', api.tree.close_node, opts('Close'))
            --vim.keymap.set('n', 'l', api.node.navigate.parent_close, opts('Close Parent'))
        end
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
}
