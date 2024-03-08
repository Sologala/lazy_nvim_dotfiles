return {
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("lazygit")
            vim.cmd("autocmd! BufEnter *:lua require('lazygit.utils').project_root_dir()")
        end,
    },
}
