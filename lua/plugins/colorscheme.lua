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
	{
		"datsfilipe/vesper.nvim",
		cmd = "Vesper",
		config = function()
			vim.cmd("colorscheme kanagawa") -- Set color scheme when loaded
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
		"sainnhe/gruvbox-material",
		cmd = "GruvboxMaterial",
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		cmd = "VSCode",
		config = function()
			vim.cmd("colorscheme vscode")
		end,
	},
	{
		"raphamorim/lucario",
		cmd = "Lucario",
		config = function()
			vim.cmd("colorscheme lucario")
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
		cmd = "RosePine",
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
	{
		"tanvirtin/monokai.nvim",
		cmd = "Monokai",
		config = function()
			vim.cmd("colorscheme monokai")
		end,
	},
	{
		"mhartington/oceanic-next",
		cmd = "OceanicNext",
		config = function()
			vim.cmd("colorscheme OceanicNext")
		end,
	},
	{
		"shaunsingh/solarized.nvim",
		cmd = "Solarized",
		config = function()
			vim.cmd("colorscheme solarized")
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- Surprisingly heavy plugin, so lazy load it
		event = "VeryLazy",

		config = function()
			-- Set up rainbow-delimiters
			require("rainbow-delimiters.setup").setup()

			-- Function to set rainbow highlights based on current colorscheme
			local function set_rainbow_colors()
				-- Link to common syntax groups that exist in most colorschemes
				vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { link = "Special" })
				vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { link = "Function" })
				vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { link = "String" })
				vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { link = "Constant" })
				vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { link = "Identifier" })
				vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { link = "Statement" })
				vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { link = "Type" })
			end

			-- Set colors initially
			set_rainbow_colors()

			-- Create an autocommand to update colors when colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_rainbow_colors,
			})
		end,
	},
}
