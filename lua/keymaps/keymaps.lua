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
-- keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
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


local function git_diff_to_buffer()
    -- 创建一个新的缓冲区
    local buf = vim.api.nvim_create_buf(false, true)

    -- 显示新缓冲区
    vim.api.nvim_command('botright vsplit')
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)

    -- 执行git diff --staged命令
    local job = require('plenary.job'):new({
        command = 'git',
        args = { 'diff', '--staged' },
        on_stdout = function(_, data)
            if data then
                -- 使用vim.schedule确保在主事件循环中执行
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { data })
                end)
            end
        end,
        on_stderr = function(_, data)
            if data then
                -- 使用vim.schedule确保在主事件循环中执行
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "Error: " .. data })
                end)
            end
        end,
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                -- 使用vim.schedule确保在主事件循环中执行
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(buf, -1, -1, false,
                        { "Git command failed with exit code: " .. return_val })
                end)
            end
        end,
    })

    -- 启动作业
    job:start()
end

-- 添加命令以方便使用
vim.api.nvim_create_user_command('GitDiffToBuffer', git_diff_to_buffer, {})

local wk = require("which-key")
wk.add({
    { "<space>e",  "<cmd>NvimTreeToggle<cr>",     desc = "File",                mode = "n" },
    { "<space>E",  "<cmd>NvimTreeFindFile<cr>",   desc = "GetCurrFile",         mode = "n" },
    { "<space>r",  "<cmd>Telescope oldfiles<cr>", desc = "HistoryFiles",        mode = "n" },
    { "<space>C",  "<cmd>%bd|e#<CR>",             desc = "Close Other Buffers", mode = "n" },
    { "<space>o",  "<cmd>AerialToggle!<CR>",      desc = "Outlines",            mode = "n" },

    { "<space>t",  group = "Trouble" }, -- group
    { "<space>tt", "<cmd>Trouble todo<cr>",       desc = "ToggleTrouble",       mode = "n" },
    { "<space>tq", "<cmd>Trouble quickfix<cr>",   desc = "Quick",               mode = "n" },

})

wk.add({
    { "<space>g",  group = "Git" },
    { "<space>gf", "<cmd>DiffviewFileHistory<CR>",                              desc = "File History",      mode = "n" },
    { "<space>gp", "<cmd>DiffviewOpen<CR>",                                     desc = "Diff Project",      mode = "n" },
    { "<space>gn", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",               desc = "Next Hunk",         mode = "n" },
    { "<space>gN", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",               desc = "Prev Hunk",         mode = "n" },
    { "<space>gl", "<cmd>lua require 'gitsigns'.blame_line({full = true})<cr>", desc = "Blame",             mode = "n" },
    { "<space>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",              desc = "Reset Hunk",        mode = "n" },
    { "<space>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",            desc = "Reset Buffer",      mode = "n" },
    { "<space>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",              desc = "Stage Hunk",        mode = "n" },
    { "<space>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>",            desc = "Stage Buffer",      mode = "n" },
    { "<space>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",         desc = "Undo Stage Hunk",   mode = "n" },
    { "<space>gU", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",         desc = "Undo Stage Hunk",   mode = "n" },
    { "<space>go", "<cmd>Telescope git_status<cr>",                             desc = "Open changed file", mode = "n" },
    { "<space>gb", "<cmd>Telescope git_branches<cr>",                           desc = "Checkout branch",   mode = "n" },
    { "<space>gc", "<cmd>Telescope git_commits<cr>",                            desc = "Checkout commit",   mode = "n" },
    { "<space>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                           desc = "Diff",              mode = "n" },
})

wk.add({
    { "<space>R",  group = "Replace" },
    { "<space>Rf", "<cmd>lua require('spectre').open_file_search()<CR>",              desc = "Replace File",    mode = "n" },
    { "<space>Rp", "<cmd>lua require('spectre').open()<CR>",                          desc = "Replace Project", mode = "n" },
    { "<space>Rs", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = "Search",          mode = "n" },
})

wk.add({
    { "<space>l",  group = "LSP" },
    { "<space>ll", "<cmd>lua vim.lsp.buf.code_action()<cr>",       desc = "Code Action",           mode = "n" },
    { "<space>ld", "<cmd>Telescope lsp_document_diagnostics<cr>",  desc = "Document Diagnostics",  mode = "n" },
    { "<space>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics", mode = "n" },
    { "<space>lf", "<cmd>Format<cr>",                              desc = "Format",                mode = "n" },
    { "<space>li", "<cmd>LspInfo<cr>",                             desc = "Info",                  mode = "n" },
    { "<space>lI", "<cmd>Mason<cr>",                               desc = "Installer Info",        mode = "n" },
    { "<space>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",  desc = "Next Diagnostic",       mode = "n" },
    { "<space>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",  desc = "Prev Diagnostic",       mode = "n" },
    { "<space>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",            desc = "Rename",                mode = "n" },
    { "<space>lc", "<cmd>Vscode<cr>",                              desc = "vscode",                mode = "n" },
})

wk.add({
    { "<space>h",  group = "Help" },
    { "<space>hc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
    { "<space>hh", "<cmd>Telescope help_tags<cr>",   desc = "Find Help",   mode = "n" },
    { "<space>hM", "<cmd>Telescope man_pages<cr>",   desc = "Man Pages",   mode = "n" },
    { "<space>hR", "<cmd>Telescope registers<cr>",   desc = "Registers",   mode = "n" },
    { "<space>hk", "<cmd>Telescope keymaps<cr>",     desc = "Keymaps",     mode = "n" },
    { "<space>hC", "<cmd>Telescope commands<cr>",    desc = "Commands",    mode = "n" },
})
