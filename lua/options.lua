vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.conceallevel = 1
-- vim.opt.wrap = false

-- Better folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.opt.scrolloff = 999
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- Set lower LSP log level
vim.lsp.set_log_level("warn")

-- Optional Copilot setting placeholders
-- vim.g.copilot_settings = { selectedCompletionModel = "Claude 3.7 Sonnet" }
-- vim.g.copilot_integration_id = "vscode-chat"
