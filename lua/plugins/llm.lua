return {

    {
        "frankroeder/parrot.nvim",
        dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
        -- optionally include "rcarriga/nvim-notify" for beautiful notifications
        event = "VeryLazy",
        config = function()
            require("parrot").setup {
                -- Providers must be explicitly added to make them available.
                providers = {
                    -- provide an empty list to make provider available (no API key required)
                    ollama = {},
                },
                chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
                chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
                chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
                chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
                hooks = {
                }
            }
        end,

    }

}
