return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- Load completion when entering insert mode
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- Add other sources if you use them:
		-- 'hrsh7th/cmp-buffer',
		-- 'hrsh7th/cmp-path',
		-- 'hrsh7th/cmp-cmdline',
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				-- Add other sources if needed:
				-- {name = 'buffer'},
				-- {name = 'path'},
			},
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- Add any custom keybindings here
				-- For example:
				-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
				-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
				-- ['<C-Space>'] = cmp.mapping.complete(),
				-- ['<C-e>'] = cmp.mapping.abort(),
				-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
			}),
		})
	end,
}
