return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Code Formatting (from null-ls)
            local LspFormattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})

            -- On LSP Server Attach
            local on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                local bufopts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, bufopts)
                --[[ vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts) ]]
                vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)

                vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_prev({ border = "rounded" }), bufopts)
                vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_next({ border = "rounded" }), bufopts)


                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)

                -- vim.keymap.set("n", "<A-j>", vim.diagnostic.goto_next)
                -- vim.keymap.set("n", "<A-k>", vim.diagnostic.goto_prev)

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = LspFormattingAugroup, buffer = bufnr })
                end
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Language Servers
            local lspconfig = require("lspconfig")

            -- Generic Settings
            local generic_servers = { "svelte", "tailwindcss" }
            for _, server in ipairs(generic_servers) do
                lspconfig[server].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end
            lspconfig.pyright.setup {
                on_attach = on_attach,
                settings = {
                    pyright = { autoImportCompletion = true, },
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = 'openFilesOnly',
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = 'off'
                        }
                    }
                } }

            -- Lua
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim", "describe", "before_each", "after_each", "it" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = {
                                "/home/ziontee113/.config/nvim-custom-plugin/zion-kit/",
                            },
                        },
                        telemetry = {
                            enable = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            })
            -- cpp
            lspconfig.clangd.setup({
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("build", "out"),
                cmd = {
                    "clangd",             -- NOTE: 只支持clangd 13.0.0 及其以下版本，新版本会有问题
                    "--background-index", -- 后台建立索引，并持久化到disk
                    "--clang-tidy",       -- 开启clang-tidy
                    -- 指定clang-tidy的检查参数， 摘抄自cmu15445. 全部参数可参考 https://clang.llvm.org/extra/clang-tidy/checks
                    "--completion-style=detailed",
                    "--cross-file-rename=true",
                    --"--header-insertion=iwyu",
                    "--pch-storage=memory",
                    -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
                    "--function-arg-placeholders=true",
                    "--log=verbose",
                    --"--ranking-model=decision_forest",
                    "--compile-commands-dir=.",
                    -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
                    --"--header-insertion-decorators",
                    "--fallback-style=Microsoft",
                    "--header-insertion=never",
                    "-j=24",
                    "--pretty",
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "cland", "pyright" },
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
}
