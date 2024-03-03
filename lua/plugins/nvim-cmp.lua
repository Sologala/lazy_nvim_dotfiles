return {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load() -- load freindly-snippets
            require("luasnip.loaders.from_vscode").load({
                paths = {                                      -- load custom snippets
                    vim.fn.stdpath("config") .. "/my-snippets"
                }
            })
        end,
    },
    { 'saadparwaiz1/cmp_luasnip' },
    {
        "Sologala/cmp-en-hint"
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body)     -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    documentation = {
                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    },
                    -- documentation = cmp.config.window.bordered(),
                },
                kind_icons = {
                    Class = " ",
                    Color = " ",
                    Constant = "ﲀ ",
                    Constructor = " ",
                    Enum = "練",
                    EnumMember = " ",
                    Event = " ",
                    Field = " ",
                    File = "",
                    Folder = " ",
                    Function = " ",
                    Interface = "ﰮ ",
                    Keyword = " ",
                    Method = " ",
                    Module = " ",
                    Operator = "",
                    Property = " ",
                    Reference = " ",
                    Snippet = " ",
                    Struct = " ",
                    Text = " ",
                    TypeParameter = " ",
                    Unit = "塞",
                    Value = " ",
                    Variable = " ",
                },
                source_names = {
                    nvim_lsp = "(LSP)",
                    treesitter = "(TS)",
                    emoji = "(Emoji)",
                    path = "(Path)",
                    en_hint = "(Eng)",
                    calc = "(Calc)",
                    cmp_tabnine = "(Tabnine)",
                    -- vsnip = "(Snippet)",
                    luasnip = "(Snippet)",
                    buffer = "(Buffer)",
                    spell = "(Spell)",
                },
                duplicates = {
                    buffer = 1,
                    path = 1,
                    nvim_lsp = 0,
                    luasnip = 1,
                },
                duplicates_default = 0,
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    ["<Tab>"] = cmp.mapping.confirm { select = true },
                    ["<C-c>"] = cmp.mapping.abort(),
                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --         cmp.mapping.confirm()
                    --         -- elseif luasnip.expandable() then
                    --         --     luasnip.expand()
                    --         -- elseif luasnip.expand_or_jumpable() then
                    --         --     luasnip.expand_or_jump()
                    --         -- elseif check_backspace() then
                    --         --     fallback()
                    --     else
                    --         fallback()
                    --     end
                    -- end, {
                    --     "i",
                    --     "s",
                    -- }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "treesitter" },
                    { name = 'luasnip' }, -- For luasnip users.
                    {
                        name = 'en_hint',
                        keyword_length = 2,
                        option = {
                            convert_case = true,
                            loud = true
                            --dict = '/usr/share/dict/words'
                        }
                    }
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                })
            })
        end,

    },
}
