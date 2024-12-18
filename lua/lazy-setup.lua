local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- { "bling/vim-bufferline" },
	{ import = "plugins" },
        { "xiyaowong/transparent.nvim" },
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	dependencies = { "echasnovski/mini.icons" },
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.startify").config)
	-- 	end,
	-- },
}, {
	performance = {
		cache = {
			enabled = true,
			-- Path where the cache is stored
			path = vim.fn.stdpath("cache") .. "/lazy/cache",
			-- What to cache:
			config = true, -- Cache config files
			data = true, -- Cache require() calls
			reset_packpath = true, -- Reset packpath when loading cache
		},
		reset_packpath = true, -- Reset packpath when loading plugins
		rtp = {
			reset = true, -- Reset runtimepath when loading plugins
			-- Paths that shouldn't be reset:
			paths = {}, -- Add any custom paths here
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
