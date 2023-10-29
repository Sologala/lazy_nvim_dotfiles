local M = {}

M.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.ends_with = function(str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

-- file exist?
M.exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end


M.SaveAndExit = function()
  -- wirte all buffer first
  vim.api.nvim_command(":wa")
  -- quit all buffer
  vim.api.nvim_command(":qa")
end

M.GetCursorWord = function()
  -- wirte all buffer first
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":/" .. word)
end
M.GetWord = function()
    local word = vim.api.nvim_call_function("expand", { "<cword>" })
    return word
end
M.FindCursorWord = function()
    local ts = require('telescope.builtin')
--    vim.notify(vim.api.nvim_call_function("expand", { "<cword>" }))
    ts.live_grep({default_text=vim.api.nvim_call_function("expand", { "<cword>" })})
end
return M
