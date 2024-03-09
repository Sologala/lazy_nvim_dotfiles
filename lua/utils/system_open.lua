local M = {}


function M.fn(abs_path)
    M.cmd = nil
    M.args = {}
    if M.is_windows
    then
        M.cmd = "cmd"
        M.args = { "/c", "start", '""' }
    elseif M.is_macos then
        M.cmd = "open"
    elseif M.is_unix then
        M.cmd = "xdg-open"
    end

    local process = {
        cmd = M.cmd,
        args = M.args,
        errors = "\n",
        stderr = vim.loop.new_pipe(false),
    }
    table.insert(process.args, abs_path)

    local opts = {
        args = process.args,
        stdio = { nil, nil, process.stderr },
        detached = true,
    }

    process.handle, process.pid = vim.loop.spawn(process.cmd, opts, function(code)
        process.stderr:read_stop()
        process.stderr:close()
        process.handle:close()
        if code ~= 0 then
            vim.notify(string.format("system_open failed with return code %d: %s", code, process.errors))
        end
    end)

    table.remove(process.args)
    if not process.handle then
        vim.notify(string.format("system_open failed to spawn command '%s': %s", process.cmd, process.pid))
        return
    end
    vim.loop.read_start(process.stderr, function(err, data)
        if err then
            return
        end
        if data then
            process.errors = process.errors .. data
        end
    end)
    vim.loop.unref(process.handle)
end

M.is_unix = vim.fn.has "unix" == 1
M.is_macos = vim.fn.has "mac" == 1 or vim.fn.has "macunix" == 1
M.is_wsl = vim.fn.has "wsl" == 1
-- false for WSL
M.is_windows = vim.fn.has "win32" == 1 or vim.fn.has "win32unix" == 1

return M
