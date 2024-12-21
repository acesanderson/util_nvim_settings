return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		views = {
			notify = {
				timeout = 500, --.5 seconds
			},
		},
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
}
