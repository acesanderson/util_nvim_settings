return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- Last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"lua", -- for neovim config
			"vimdoc", -- for help files
			"vim", -- for .vim files
			"markdown", -- for markdown, obsidian files
			"markdown_inline", -- for markdown, obsidian files
			"python", -- always load Python parser
		},
		-- Automatically install parsers when entering buffer
		auto_install = false,

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- List of parsers to ignore
		ignore_install = {},
	},
	config = function(_, opts)
		-- Define filetype to parser mapping
		local parser_mapping = {
			javascript = { "javascript", "jsx" },
			typescript = { "typescript", "tsx" },
			yaml = { "yaml" },
			json = { "json", "jsonc" },
			html = { "html" },
			css = { "css" },
			bash = { "bash" },
			-- Exclude Python since it's always loaded
			python = {}, -- No need to list as it's always installed
		}

		-- Setup treesitter
		require("nvim-treesitter.configs").setup(opts)

		-- Create autocmd for lazy loading other parsers
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local ft = vim.bo.filetype
				if parser_mapping[ft] then
					for _, parser in ipairs(parser_mapping[ft]) do
						vim.cmd("TSInstall " .. parser)
					end
				end
			end,
		})
	end,
}
