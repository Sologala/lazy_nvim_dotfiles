return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        auto_close = true,
        jump = { "<tab>", "<2-leftmouse>" },   -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" },              -- open buffer in new split
        open_vsplit = { "<c-v>" },             -- open buffer in new vsplit
        open_tab = { "<c-t>" },                -- open buffer in new tab
        jump_close = { "o", "<cr>" },          -- jump to the diagnostic and close the list
    },
}
