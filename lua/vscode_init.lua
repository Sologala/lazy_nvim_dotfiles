
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = {
    { import = "plugins.flash" },
  }
})


local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ";", "<Nop>", opts)
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
