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
			-- You can uncomment these presets if you want additional features
			-- presets = {
			--     bottom_search = true,         -- Moves search bar to bottom of screen
			--     command_palette = true,       -- Combines command line and popup menu
			--     long_message_to_split = true, -- Opens long messages in a split
			--     inc_rename = false,           -- Adds input dialog for incremental rename
			--     lsp_doc_border = false,       -- Adds border around LSP documentation
			-- },
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
	{ "tpope/vim-dadbod", cmd = "DBUI" },
	{ "kristijanhusak/vim-dadbod-ui", cmd = "DBUI" },
	{ "kristijanhusak/vim-dadbod-completion", cmd = "DBUI" },
	{ "github/copilot.vim" },
	{ "bling/vim-bufferline" },
	{ import = "plugins" },
	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
})
