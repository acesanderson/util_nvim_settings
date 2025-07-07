-- Abbreviate substitute commands to use very magic
vim.cmd([[
  cabbrev %s/ %s/\v
  cabbrev %s? %s?\v
  cabbrev s/ s/\v
  cabbrev s? s?\v
]])

-- Autoformat Lua files on save with Stylua
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.lua",
	callback = function()
		vim.fn.system("stylua " .. vim.fn.expand("%"))
		vim.cmd("e!")
	end,
})
