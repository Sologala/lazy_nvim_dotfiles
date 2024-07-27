return {
    {
        "terrortylor/nvim-comment",

        config = function()
            local opts = {
                -- Linters prefer comment and line to have a space in between markers
                marker_padding = true,
                -- should comment out empty or whitespace only lines
                comment_empty = true,
                -- trim empty comment whitespace
                comment_empty_trim_whitespace = true,
                -- Should key mappings be created
                create_mappings = true,
                -- Normal mode mapping left hand side
                line_mapping = "gcc",
                -- Visual/Operator mapping left hand side
                operator_mapping = "gc",
                -- text object mapping, comment chunk,,
                comment_chunk_text_object = "ic",
                -- Hook function to call before commenting takes place
                hook = nil
            }
            require('nvim_comment').setup(opts)
            vim.cmd([[
                augroup set-commentstring-ag
                autocmd!
                autocmd BufEnter *.c,*.cc,*.cpp,*.h,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
                " when you've changed the name of a file opened in a buffer, the file type may have changed
                autocmd BufFilePost *.c,*.cc,*.cpp,*.h,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
                augroup END
                ]]
            )
        end,
    },
}
