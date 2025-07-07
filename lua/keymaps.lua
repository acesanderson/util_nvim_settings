local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- Show Python provider
map("n", "<leader>vp", function()
	print("python3_host_prog: " .. (vim.g.python3_host_prog or "not set"))
end, { desc = "Show Python provider path" })

-- File tree
map("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", opts)
require("transparent").clear_prefix("NvimTree")

-- Formatting and editing
map("n", "<leader>fj", ":%!jq .<CR>", vim.tbl_extend("force", opts, { desc = "Format JSON" }))
vim.api.nvim_set_keymap("n", "<Leader>o", "mpo<Esc>p", opts)
vim.api.nvim_set_keymap("n", "<Leader>O", "mpO<Esc>`p", opts)
map("n", "<leader>ifm", 'iif __name__ == "__main__":<CR>', opts)

-- Run Python file (function lives in tools.lua)
map("n", "<leader>r", ":lua run_python_file()<CR>", opts)

-- Stylua format
map("n", "<leader>st", function()
	vim.fn.system("stylua " .. vim.fn.expand("%"))
	vim.cmd("e!")
end)
