local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ";", "<Nop>", opts)
--vim.g.mapleader = ";"
--vim.g.maplocalleader = ";"

-- Modes normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t", command_mode = "c",

-- nvim-tree
-- keymap("n", "<space>e", ":NvimTreeToggle<cr>", opts)

-- Normal --
-- Better window navigation

-- If tmux.nvim is opened, then the binding here should be turned off
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<silent>*", "syiw<Esc>: let @/ = @s<CR>", opts)

-- keymap("n", "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", opts)
-- keymap("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", opts)
-- keymap("n", "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", opts)
-- keymap("n", "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", opts)



-- NOTE: require winshit plugin
keymap("n", "<C-w>m", ":WinShift<cr>", opts)

-- i j remap to gi gj to get the consistent behaviour in wrap content mode (i.e. set wrap)
-- keymap("n", "j", "<Plug>(accelerated_jk_gj)", opts)
-- keymap("n", "k", "<Plug>(accelerated_jk_gk)", opts)


-- formatting
-- keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
-- keymap("n", "<leader>F", "<cmd>lua require('conform').format()<cr>", opts)
-- keymap("n", "<leader>F", "<cmd>GuardFmt<cr>", opts)
-- keymap('v', '<leader>f', "<ESC><cmd>lua vim.lsp.buf.format()<CR>", opts)
-- keymap('v', '<leader>f', "<cmd>GuardFmt<CR>", opts)
-- keymap('v', '<leader>f', "<ESC><cmd>lua vim.lsp.buf.formatexpr()<CR>", opts)

-- save buffer
keymap("n", "<leader>w", ":w!<cr>", opts)
-- exit cur window
keymap("n", "<leader>d", ":q<cr>", opts)
-- delete cur buffer
--keymap("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)
keymap("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)
-- exit whole program


keymap("n", "ZZ", ":lua require('utils.utils').SaveAndExit()<cr>", opts)

-- -- remap macro record key
-- keymap("n", "Q", "q", opts)
-- cancel q
keymap("n", "q", "<Nop>", opts)


-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "R", ":bnext<CR>", opts)
keymap("n", "E", ":bprevious<CR>", opts)

-- Navigate line
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)


-- Insert --
-- Press jl fast to enter
keymap("i", "jl", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)

keymap("v", "p", '"_dP', opts)


-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- bookmarks
-- keymap("n", "ma", "<cmd>Telescope vim_bookmarks current_file<cr>", opts)
-- keymap("n", "mA", "<cmd>Telescope vim_bookmarks all<cr>", opts)

-- file finder
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
-- switch source header file
keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
-- find all lsp references
keymap("n", "<leader>u", "<cmd>Trouble lsp_references<cr>", opts)

keymap("n", "<space>F", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", opts)
keymap("v", "<space>F", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<cr>", opts)

keymap("n", "<leader>s", "<cmd>lua require('flash').jump()<cr>", opts)
keymap("v", "<leader>s", "<cmd>lua require('flash').jump()<cr>", opts)
-- keymap("n", "f", "<cmd>lua require('flash').jump()<cr>", opts)
-- keymap("v", "f", "<cmd>lua require('flash').jump()<cr>", opts)
-- keymap("v", "me", "<cmd>Translate ZH<cr><Esc>", opts)
-- keymap("v", "mz", "<cmd>Translate EN<cr><Esc>", opts)

local function open_vscode_if_present()
    local cwd = vim.fn.getcwd()
    local vscode_path = cwd .. "/.vscode"

    if vim.fn.isdirectory(vscode_path) == 1 then
        -- 執行 `code` 命令
        os.execute("code .")
    else
        -- 顯示消息
        os.execute("code .")
        print(".vscode directory not found.")
    end
end

vim.api.nvim_create_user_command("Vscode", open_vscode_if_present, {})
vim.api.nvim_create_user_command("Cfp", function()
    print(vim.fn.expand('%:p'))
end, {})

vim.api.nvim_create_user_command("Cly", function()
    local file_name = vim.fn.expand('%')
    local line_number = vim.fn.line('.')
    local result = string.format("%s:%d", file_name, line_number)
    vim.fn.setreg('+', result)
    print('Copied: ' .. result)
end, {})
