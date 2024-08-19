return {
    "uga-rosa/translate.nvim",
    opts = {
        default = {
            command = "google",
            output = "replace",
        },
        preset = {
            output = {
                register = {
                    name = "+",
                },
                split = {
                    position = "bottom",
                    min_size = 3,
                    max_size = 0.3,
                    name = "translate://output",
                    filetype = "translate",
                    append = true,
                },
            },
        },
    }
}
