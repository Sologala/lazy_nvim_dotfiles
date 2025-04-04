-- Define a function to check that ollama is installed and working
local function get_condition()
    return package.loaded["ollama"] and require("ollama").status ~= nil
end


-- Define a function to check the status and return the corresponding icon
local function get_status_icon()
    local status = require("ollama").status()
    local ollama_is_running = get_condition()

    if ollama_is_running then
        if status == "IDLE" then
            return '󰳆'
        elseif status == "WORKING" then
            return '󰉁'
        else
            return '󰉃'
        end
    else
        return '󰉃'
    end
end

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {
                {
                    function()
                        local cwd = vim.fn.getcwd()
                        -- 使用 Lua 的模式匹配来分割路径
                        local segments = {}
                        for segment in string.gmatch(cwd, "[^\\/]+") do
                            table.insert(segments, segment)
                        end
                        -- 获取最后两个部分
                        local last_two_segments = {}
                        if #segments > 0 then
                            table.insert(last_two_segments, 1, segments[#segments])
                        end
                        if #segments > 1 then
                            table.insert(last_two_segments, 1, segments[#segments - 1])
                        end
                        -- 用文件路径分隔符 ('/' 或 '\\') 将这两个部分连接起来
                        return table.concat(last_two_segments, '/')
                    end,
                    icon = '📁', -- 可选：提供一个图标表示工作目录
                    padding = 0,
                    -- color = { bg = '#006400' }
                },
                'mode'
            },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filename', color = { bg = 'green' } }
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress', get_status_icon },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
}
