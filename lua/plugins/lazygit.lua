return {
    -- {
    --     "kdheepak/lazygit.nvim",
    --     -- optional for floating window border decoration
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    --
    --     cmd = {
    --         "LazyGit",
    --         "LazyGitConfig",
    --         "LazyGitCurrentFile",
    --         "LazyGitFilter",
    --         "LazyGitFilterCurrentFile",
    --     },
    --     -- order to load the plugin when the command is run for the first time
    --     -- keys = {
    --     --     { "<space>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    --     -- },
    --     config = function()
    --         require("telescope").load_extension("lazygit")
    --         -- vim.cmd("autocmd! BufEnter *:lua require('lazygit.utils').project_root_dir()")
    --     end,
    -- },
    {
        "willothy/flatten.nvim",
        config = true,
        -- or pass configuration with
        opts = function()
            ---@type Terminal?
            local saved_terminal

            return {
                window = {
                    open = "alternate",
                },
                hooks = {
                    should_block = function(argv)
                        -- Note that argv contains all the parts of the CLI command, including
                        -- Neovim's path, commands, options and files.
                        -- See: :help v:argv

                        -- In this case, we would block if we find the `-b` flag
                        -- This allows you to use `nvim -b file1` instead of
                        -- `nvim --cmd 'let g:flatten_wait=1' file1`
                        return vim.tbl_contains(argv, "-b")

                        -- Alternatively, we can block if we find the diff-mode option
                        -- return vim.tbl_contains(argv, "-d")
                    end,
                    pre_open = function()
                        local term = require("toggleterm.terminal")
                        local termid = term.get_focused_id()
                        saved_terminal = term.get(termid)
                    end,
                    post_open = function(bufnr, winnr, ft, is_blocking)
                        if is_blocking and saved_terminal then
                            -- Hide the terminal while it's blocking
                            saved_terminal:close()
                        else
                            -- If it's a normal file, just switch to its window
                            vim.api.nvim_set_current_win(winnr)
                        end

                        -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
                        -- If you just want the toggleable terminal integration, ignore this bit
                        if ft == "gitcommit" or ft == "gitrebase" then
                            vim.api.nvim_create_autocmd("BufWritePost", {
                                buffer = bufnr,
                                once = true,
                                callback = vim.schedule_wrap(function()
                                    vim.api.nvim_buf_delete(bufnr, {})
                                end),
                            })
                        end
                    end,
                    block_end = function()
                        -- After blocking ends (for a git commit, etc), reopen the terminal
                        vim.schedule(function()
                            if saved_terminal then
                                saved_terminal:open()
                                saved_terminal = nil
                            end
                        end)
                    end,
                },
            }
        end,
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
    },
}
