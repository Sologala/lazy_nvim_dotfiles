return {
    {
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
            {
                "mw",
                ":<c-u>lua require('ollama').prompt('ExplainWord')<cr>",
                desc = "ollama ExplainWord",
                mode = { "v" },
            },
        },

        ---@type Ollama.Config
        opts = {
            -- model = "omercelik/gemmax2-9b",
            -- model = "zongwei/gemma3-translator:4b",
            -- model = "qwen3:1.7b",
            model = "qwen3:0.6b",
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
                    prompt = "/no_think Translate this from English to Chinese:\nEnglish: $sel\nChinese: ",
                    action = "display",
                    -- extract = "```$ftype\n(.-)```"
                    -- extract = "```$ftype\n(.-)```"
                },
                TranslateCN2Eng = {
                    prompt = "/no_think Translate this from Chinese to English:\nChinese: $sel\nEnglish: ",
                    action = "display",
                    -- extract = "```$ftype\n(.-)```"
                },
                ExplainWord = {
                    prompt = "/no_think 用中文解释一下这个单词, 词性，并造句举例及其翻译: $sel ",
                    -- model = "llama2-chinese",
                    action = "display",
                    -- extract = "```$ftype\n(.-)```"
                },
                ExplainCode = {
                    prompt = "/no_think 解释一下代码 \n```$ftype\n$sel\n```",
                    -- model = "llama2-chinese",
                    action = "display"
                    -- extract = "```$ftype\n(.-)```"
                },
                SummaryGitCommit = {
                    prompt =
                    "/no_think 请根据以下 Git diff 内容生成符合 Conventional Commits 规范的 commit message：\n $buf",
                    action = "display"
                    -- extract = "```$ftype\n(.-)```"
                },
                DescripeThisFunc = {
                    prompt =
                    "/no_think 给一下函数或者类生成对应简介 \n```$ftype\n$sel\n```",
                    action = "insert"
                    -- extract = "```$ftype\n(.-)```"
                }
            }
        }
    }
}
