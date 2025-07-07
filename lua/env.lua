--- Purpose of this script:
--- -- This script is designed to find the Python interpreter in a virtual environment
--- --    by searching for a `.venv/bin/python` file in the current file's directory
--- --    and its parent directories.
--- --- -- It sets the `g:python3_host_prog` variable to the found interpreter path,
--- --- --    which is used by Neovim to determine which Python interpreter to use.
--- Why do we need this? We have switched to a uv-based workflow where every project has a venv.

--- lua/env.lua
local M = {}

--- Recursively searches up from current file to find `.venv/bin/python`
function M.find_and_set_python_host()
  local path = vim.fn.expand("%:p:h") -- current file's directory
  while path ~= "/" do
    local candidate = path .. "/.venv/bin/python"
    if vim.fn.executable(candidate) == 1 then
      vim.g.python3_host_prog = candidate
      vim.notify("[env.lua] Using Python provider: " .. candidate, vim.log.levels.INFO)
      return candidate
    end
    path = vim.fn.fnamemodify(path, ":h")
  end

  vim.notify("[env.lua] No .venv/bin/python found", vim.log.levels.WARN)
  return nil
end

return M
