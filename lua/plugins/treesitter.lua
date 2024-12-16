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
			"javascript",
			"json",
			"jsonc",
			"bash",
			"regex",
		},
		-- Automatically install parsers when entering buffer
		auto_install = false,

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- List of parsers to ignore
		ignore_install = {},
	},
	config = function()
		-- Define filetype to parser mapping
		local parser_mapping = {
			javascriptreact = { "tsx" }, -- Add this line for JSX files
			typescript = { "typescript", "tsx" },
			typescriptreact = { "tsx" },
			yaml = { "yaml" },
			html = { "html" },
			css = { "css" },
			bash = { "bash" },
			sql = { "sql" },
			-- Exclude Python since it's always loaded
			python = {}, -- No need to list as it's always installed
		}

		-- Setup treesitter
		require("nvim-treesitter.configs").setup({

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Leader>ss",
					node_incremental = "<Leader>si",
					scope_incremental = "<Leader>sc",
					node_decremental = "<Leader>bd",
				},
			},
			require("nvim-treesitter.configs").setup({
				textobjects = {
					textobjects = {
						swap = {
							enable = true,
							swap_next = {
								["<leader>a"] = "@parameter.inner",
							},
							swap_previous = {
								["<leader>A"] = "@parameter.inner",
							},
						},
					},
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
				},
			}),
		})
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
