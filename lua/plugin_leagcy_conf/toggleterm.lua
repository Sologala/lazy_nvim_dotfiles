local toggleterm = require("toggleterm")

function OS()
    return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

if OS() == "win" then
    vim.cmd([[
set shell=powershell
set shellcmdflag=-command
set shellquote=\"
set shellxquote=
]])
end

toggleterm.setup({
    size = 20,
    -- open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    --
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- vim.cmd("autocmd! BufEnter *:lua require('lazygit.utils').project_root_dir()")

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-q>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
            { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})
function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<space>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })


local cmd = Terminal:new({
    direction = "float",
    float_opts = {
        border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-q>", "<cmd>lua _CMD_TOGGLE()<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>lua _CMD_TOGGLE()<CR>",
            { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})
function _CMD_TOGGLE()
    cmd:toggle()
end

vim.api.nvim_set_keymap("n", [[<c-\>]], "<cmd>lua _CMD_TOGGLE()<CR>", { noremap = true, silent = true })
