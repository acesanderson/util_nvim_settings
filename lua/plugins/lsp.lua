return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Setup mason first
		require("mason").setup({})

		local lspconfig = require("lspconfig")

		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- Configure servers with their specific filetypes
		local servers = {
			pyright = { filetypes = { "python" } },
			lua_ls = { filetypes = { "lua" } },
			bashls = { filetypes = { "sh", "bash" } },
			html = { filetypes = { "html" } },
			dockerls = { filetypes = { "dockerfile" } },
			jsonls = { filetypes = { "json", "jsonc" } },
			cssls = { filetypes = { "css", "scss", "less" } },
			yamlls = { filetypes = { "yaml", "yml" } },
			sqlls = { filetypes = { "sql" } },
		}

		-- Setup mason-lspconfig
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = false,
		})

		-- Setup each LSP server
		for server, config in pairs(servers) do
			lspconfig[server].setup({
				filetypes = config.filetypes,
				capabilities = lspconfig_defaults.capabilities,
			})
		end

		-- LSP keybindings (only active when LSP is attached)
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "x" }, "<F3>", vim.lsp.buf.format, opts)
				vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
			end,
		})
	end,
}
