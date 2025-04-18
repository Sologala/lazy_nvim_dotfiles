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
            model = "zongwei/gemma3-translator:1b",
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
                    prompt = "Translate from English to Chinese: $sel",
                    action = "display",
                    -- extract = "```$ftype\n(.-)```"
                    -- extract = "```$ftype\n(.-)```"
                },
                TranslateCN2Eng = {
                    prompt = "Translate from Chinese to English: $sel",
                    action = "display",
                    -- extract = "```$ftype\n(.-)```"
                },
                ExplainWord = {
                    prompt = "用中文解释一下这个单词, 词性，并造句举例及其翻译: $sel",
                    -- model = "llama2-chinese",
                    action = "display",
                    -- extract = "```$ftype\n(.-)```"
                },
                ExplainCode = {
                    prompt = "解释一下代码 \n```$ftype\n$sel\n```",
                    -- model = "llama2-chinese",
                    action = "display"
                    -- extract = "```$ftype\n(.-)```"
                }
            }
        }
    },
    {
        'huggingface/llm.nvim',
        opts = {
            -- cf Setup
            backend = "ollama",             -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
            model = "codellama:latest",
            url = "http://localhost:11434", -- llm-ls uses "/api/generate"
            -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
            request_body = {
                -- Modelfile options for the model you use
                options = {
                    temperature = 0.2,
                    top_p = 0.95,
                }
            },
            accept_keymap = "<leader><Tab>",
            dismiss_keymap = "<S-Tab>",
            enable_suggestions_on_startup = false,
            enable_suggestions_on_files = { "*.py", "*.cpp", "*.cc" }
        }

    }
}
