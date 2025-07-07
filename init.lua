-- Leader keys must be set before plugins or keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set Python host from active venv
require("env").find_and_set_python_host()

-- Load modular config
-- -- Plugins
require("lazy-setup")
require("bufferline").setup({})
-- -- LSP and completion
require("options")
require("keymaps")
require("autocmds")
require("tools")

-- Set colorscheme, fallback to Catppuccin
local color_file = vim.fn.stdpath("config") .. "/lua/color.lua"
if vim.fn.filereadable(color_file) == 1 then
	require("color")
else
	vim.cmd.colorscheme("catppuccin-mocha")
end
