local M = {}

-----------------------------------------------------------
-- Checks if running under Windows.
-----------------------------------------------------------
function M.is_win()
---@diagnostic disable-next-line: undefined-field
  if vim.loop.os_uname().version:match('Windows') then
    return true
  else
    return false
  end
end

-----------------------------------------------------------
-- Function equivalent to basename in POSIX systems.
-- @param str the path string.
-----------------------------------------------------------
function M.basename(str)
  return string.gsub(str, "(.*/)(.*)", "%2")
end

-----------------------------------------------------------
-- Contatenates given paths with correct separator.
-- @param: var args of string paths to joon.
-----------------------------------------------------------
function M.join_paths(...)
  local path_sep = M.is_win() and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

local _base_lua_path = M.join_paths(vim.fn.stdpath('config'), 'lua')

-----------------------------------------------------------
-- Loads all modules from the given package.
-- @param package: name of the package in lua folder.
-----------------------------------------------------------
function M.glob_require(package)
  local glob_path = M.join_paths(
    _base_lua_path,
    package,
    '*.lua'
  )
  for _, path in pairs(vim.split(vim.fn.glob(glob_path), '\n')) do
    local relfilename = path:gsub(_base_lua_path, ""):gsub("%.lua", "")
    local basename = M.basename(relfilename)
    if (basename ~= 'init' and basename:sub(1, 1) ~= '_') then
      require(relfilename)
    end
  end
end

-----------------------------------------------------------
-- Strips trailing whitespaces.
-----------------------------------------------------------
function M.strip_trailing_whitespace()
  if vim.bo.modifiable then
    local line = vim.fn.line('.')
    local col = vim.fn.col('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.histdel('/', -1)
    vim.fn.cursor(line, col)
  end
end

-----------------------------------------------------------
-- Tooggles windows zoom.
-----------------------------------------------------------
function M.zoom_toggle()
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    vim.cmd(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd('resize | vertical resize')
    vim.t.zoomed = true
  end
end

return M
