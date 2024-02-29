return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Code Formatting (from null-ls)
            local LspFormattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})

            -- On LSP Server Attach
            local on_attach = function(client, bufnr)
                local lsp_signature_cfg = {
                    debug = false,                                              -- set to true to enable debug logging
                    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
                    -- default is  ~/.cache/nvim/lsp_signature.log
                    verbose = false,                                            -- show debug line number

                    bind = true,                                                -- This is mandatory, otherwise border config won't get registered.
                    -- If you want to hook lspsaga or other signature handler, pls set to false
                    doc_lines = 10,                                             -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                    -- set to 0 if you DO NOT want any API comments be shown
                    -- This setting only take effect in insert mode, it does not affect signature help in normal
                    -- mode, 10 by default

                    max_height = 12,                       -- max height of signature floating_window
                    max_width = 80,                        -- max_width of signature floating_window, line will be wrapped if exceed max_width
                    -- the value need >= 40
                    wrap = true,                           -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
                    floating_window = true,                -- show hint in a floating window, set to false for virtual text only mode

                    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
                    -- will set to true when fully tested, set to false will use whichever side has more space
                    -- this setting will be helpful if you do not want the PUM and floating win overlap

                    floating_window_off_x = 1, -- adjust float windows x position.
                    -- can be either a number or function
                    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                    -- can be either number or function, see examples

                    close_timeout = 4000, -- close floating window after ms when laster parameter is entered
                    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
                    hint_enable = true, -- virtual hint enable
                    hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
                    hint_scheme = "String",
                    hint_inline = function() return false end, -- should the hint be inline(nvim 0.10 only)?  default false
                    -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
                    -- return 'right_align' to display hint right aligned in the current line
                    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
                    handler_opts = {
                        border = "rounded"                        -- double, rounded, single, shadow, none, or a table of borders
                    },

                    always_trigger = false,                   -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

                    auto_close_after = 4,                     -- autoclose signature float win after x sec, disabled if nil.
                    extra_trigger_chars = {},                 -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                    zindex = 200,                             -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

                    padding = '',                             -- character to pad on left and right of signature can be ' ', or '|'  etc

                    transparency = nil,                       -- disabled by default, allow floating win transparent value 1~100
                    shadow_blend = 36,                        -- if you using shadow as border use this set the opacity
                    shadow_guibg = 'Black',                   -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
                    timer_interval = 200,                     -- default timer check interval set to lower value if you want to reduce latency
                    toggle_key = nil,                         -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
                    toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
                    -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
                }
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                require "lsp_signature".on_attach(lsp_signature_cfg, bufnr) -- Note: add in lsp client on-attach
                local bufopts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, bufopts)
                --[[ vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts) ]]
                vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gD", vim.lsp.buf.implementation, bufopts)
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
            local generic_servers = { "clangd", 'pyright', 'jsonls', 'cmake', 'tsserver' }
            for _, server in ipairs(generic_servers) do
                lspconfig[server].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end
            -- lspconfig.neocmake.setup {
            --     {
            --         cmd = vim.lsp.rpc.connect('127.0.0.1', '9257'),
            --         filetypes = { "cmake" },
            --         root_dir = function(fname)
            --             return nvim_lsp.util.find_git_ancestor(fname)
            --         end,
            --         single_file_support = true, -- suggested
            --         on_attach = on_attach,      -- on_attach is the on_attach function you defined
            --         init_options = {
            --             format = {
            --                 enable = false
            --             }
            --         }
            --     }
            -- }
            lspconfig.jsonls.setup {
                init_options = {
                    provideFormatter = true
                },
                root_dir = lspconfig.util.root_pattern("build", "out", ".git"),
                single_file_support = true,
            }
            lspconfig.tsserver.setup {
                cmd = { "typescript-language-server", "--stdio" },
                init_options = {
                    hostInfo = "neovim"
                },
                root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
                single_file_support = true,
            }
            lspconfig.cmake.setup {
                init_options = {
                    buildDirectory = "build"
                },
                root_dir = lspconfig.util.root_pattern("build", "out", ".git"),
                single_file_support = true,
                filetypes = { "cmake", "CMakeLists.txt" },
            }

            lspconfig.pyright.setup {
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
