vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

if vim.g.vscode then
    -- VSCode extension
    -- require("lazy_init")
    require("vscode_init")
    require("options.options")
else
    require("lazy_init")
    require("options.options")
    require("keymaps.keymaps")
    require("plugin_leagcy_conf.toggleterm")
end
