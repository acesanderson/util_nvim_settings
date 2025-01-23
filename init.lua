vim.wo.number = true
vim.wo.relativenumber = true

-- Set the leader key
vim.g.mapleader = " "

-- Set conceal level -- this hides markdown formatting characters
vim.opt.conceallevel = 1

-- disable wrap
-- vim.opt.wrap = false

-- scroll lock
vim.opt.scrolloff = 999

-- new splits open at the bottom and right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Lazy loads all our plugins (see lazy-setup.lua)
require("lazy-setup")

-- Set the colorscheme by importing from color.lua -- if it exists!
local color_file = vim.fn.stdpath("config") .. "/lua/color.lua"
if vim.fn.filereadable(color_file) == 1 then
	require("color")
else
	vim.cmd.colorscheme("catppuccin-mocha")
end

-- Open Nvim Tree
vim.keymap.set("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })
require("transparent").clear_prefix("NvimTree")

-- Pretty print json
vim.keymap.set("n", "<leader>fj", ":%!jq .<CR>", { noremap = true, silent = true, desc = "Format JSON" })
-- Open a new line below the current line
vim.api.nvim_set_keymap("n", "<Leader>o", "mpo<Esc>p", { noremap = true, silent = true })
-- Open a new line above the current line
vim.api.nvim_set_keymap("n", "<Leader>O", "mpO<Esc>`p", { noremap = true, silent = true })
-- IF name equals main boilerplate
vim.keymap.set("n", "<leader>ifm", 'iif __name__ == "__main__":<CR>', { noremap = true, silent = true })

-- Create abbreviation for substitute command
-- This allows us to effectively use "very magic" (i.e. perlesque regex) in find/replace in command mode
vim.cmd([[
  cabbrev %s/ %s/\v
  cabbrev %s? %s?\v
  cabbrev s/ s/\v
  cabbrev s? s?\v
]])

-- Shortcut to run Python files -- this is a simple way to run Python files in a floating terminal
-- We have toggleterm installed, so you likely will more often want to use <ctrl>+\ to open a terminal instead
function _G.run_python_file()
	local file = vim.fn.expand("%")
	local Terminal = require("toggleterm.terminal").Terminal
	local python_term = Terminal:new({
		cmd = "python3 " .. file,
		direction = "float",
		size = 50,
		close_on_exit = false,
	})
	python_term:toggle()
end

vim.keymap.set("n", "<leader>r", ":lua run_python_file()<CR>", { noremap = true, silent = true })

-- Clipboard settings!
-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- OSC 52 uses special escape sequences to copy and paste text to terminal emulator clipboard -- i.e. across SSH
-- vim.g.clipboard = {
-- 	name = "OSC 52",
-- 	copy = {
-- 		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 	},
-- paste = {
--   ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--   ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
-- },
-- }

-- Stylua: Lua formatter
-- Format with shortcut <leader>st
vim.keymap.set("n", "<leader>st", function()
	vim.fn.system("stylua " .. vim.fn.expand("%"))
	vim.cmd("e!") -- reload the file
end)
-- Auto-format on save for lua files
vim.api.nvim_create_autocmd("BufWritePost", { -- Changed from BufWritePre to BufWritePost
	pattern = "*.lua",
	callback = function()
		vim.fn.system("stylua " .. vim.fn.expand("%"))
		vim.cmd("e!") -- reload the file
	end,
})

vim.opt.termguicolors = true
require("bufferline").setup({})
