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
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- Here we're moving the Noice configuration into the opts table
			lsp = {
				-- This section enhances how LSP documentation appears in your editor
				override = {
					-- Improves the conversion of LSP documentation to markdown
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- Enhances how markdown is styled in the documentation window
					["vim.lsp.util.stylize_markdown"] = true,
					-- Makes completion documentation look better when using nvim-cmp
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"rest-nvim/rest.nvim",
		cmd = { "Rest" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
	},
	{ "github/copilot.vim", event = "VeryLazy" },
	-- { "bling/vim-bufferline" },
	{ "akinsho/bufferline.nvim", event = "VeryLazy" },
	{ import = "plugins" },
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	dependencies = { "echasnovski/mini.icons" },
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.startify").config)
	-- 	end,
	-- },
{ 
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	},
}, 
},
{
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
