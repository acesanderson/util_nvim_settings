return {
	-- Lazy load Catppuccin color scheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Ensures this theme loads first if present
		cmd = "Catppuccin", -- Load when this command is executed
		config = function()
			vim.cmd("colorscheme catppuccin") -- Set color scheme when loaded
		end,
	},

	-- Lazy load Kanagawa color scheme
	{
		"rebelot/kanagawa.nvim",
		cmd = "Kanagawa", -- Load when this command is executed
		config = function()
			vim.cmd("colorscheme kanagawa") -- Set color scheme when loaded
		end,
	},

	-- Lazy load Tokyo Night color scheme
	{
		"folke/tokyonight.nvim",
		cmd = "Tokyonight", -- Load when this command is executed
		config = function()
			vim.cmd("colorscheme tokyonight") -- Set color scheme when loaded
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		cmd = "Nightfox",
		config = function()
			vim.cmd("colorscheme nightfox")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		cmd = "Gruvbox",
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"savq/melange-nvim",
		cmd = "Melange",
		config = function()
			vim.cmd("colorscheme melange")
		end,
	},
	{
		"sainnhe/sonokai",
		cmd = "Sonokai",
		config = function()
			vim.cmd("colorscheme sonokai")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		cmd = "Oxocarbon",
		config = function()
			vim.cmd("colorscheme oxocarbon")
		end,
	},
	{
		"romainl/Apprentice",
		cmd = "Apprentice",
		config = function()
			vim.cmd("colorscheme apprentice")
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		cmd = "Dracula",
		config = function()
			vim.cmd("colorscheme dracula")
		end,
	},
	{
		"NLKNguyen/papercolor-theme",
		cmd = "PaperColor",
		config = function()
			vim.cmd("colorscheme PaperColor")
		end,
	},
	{
		"NTBBloodbath/doom-one.nvim",
		cmd = "DoomOne",
		config = function()
			vim.cmd("colorscheme doom-one")
		end,
	},
}
