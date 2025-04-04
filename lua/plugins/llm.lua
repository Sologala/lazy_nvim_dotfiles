return {
    "nomnivore/ollama.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
        -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oo",
            ":<c-u>lua require('ollama').prompt()<cr>",
            desc = "ollama prompt",
            mode = { "n", "v" },
        },
        -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
        {
            "me",
            ":<c-u>lua require('ollama').prompt('TranslateEng2CN')<cr>",
            desc = "ollama TranslateEng2CN",
            mode = { "v" },
        },
        {
            "mz",
            ":<c-u>lua require('ollama').prompt('TranslateCN2Eng')<cr>",
            desc = "ollama TranslateCN2Eng",
            mode = { "v" },
        },

    },

    ---@type Ollama.Config
    opts = {
        model = "deepseek-r1:1.5b",
        url = "http://127.0.0.1:11434",
        serve = {
            on_start = false,
            command = "ollama",
            args = { "serve" },
            stop_command = "pkill",
            stop_args = { "-SIGTERM", "ollama" },
        },
        -- View the actual default prompts in ./lua/ollama/prompts.lua
        prompts = {
            TranslateEng2CN = {
                prompt = "翻译以下段落为中文 \n\n```$sel```",
                -- model = "llama2-chinese",
                action = "display",
                extract = "```$ftype\n(.-)```"
            },
            TranslateCN2Eng = {
                prompt = "翻译一下段落为英语 \n\n```$sel\n```",
                -- model = "llama2-chinese",
                action = "display",
                extract = "```$ftype\n(.-)```"
            },
            ExplainCode = {
                prompt = "解释一下代码 \n```$ftype\n$sel\n```",
                -- model = "llama2-chinese",
                action = "display"
                -- extract = "```$ftype\n(.-)```"
            }
        }
    }
}
