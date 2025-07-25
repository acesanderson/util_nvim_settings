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
		-- Ensure Python is available in the environment and all servers are referencing the same Python version / venv
		vim.env.PYTHONPATH = vim.fn.getcwd() .. ":" .. (vim.env.PYTHONPATH or "")
		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)
		-- Configure standard servers (non-Python)
		local servers = {
			lua_ls = { filetypes = { "lua" } },
			yamlls = { filetypes = { "yaml", "yml" } },
			sqlls = { filetypes = { "sql" } },
		}
		-- Setup mason-lspconfig with python servers (using basedpyright instead of pyright)
		local ensure_installed = vim.list_extend(vim.tbl_keys(servers), { "ruff", "basedpyright" })
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_installation = false,
		})
		-- Setup standard (non-Python) LSP servers immediately
		for server, config in pairs(servers) do
			lspconfig[server].setup({
				filetypes = config.filetypes,
				capabilities = lspconfig_defaults.capabilities,
			})
		end
		-- Setup basedpyright with type checking ENABLED
		-- Setup basedpyright with type checking ENABLED
		require("lspconfig").basedpyright.setup({
			capabilities = lspconfig_defaults.capabilities,
			settings = {
				basedpyright = {
					analysis = {
						-- ENABLE type checking (this was previously "off")
						typeCheckingMode = "standard", -- "basic", "standard", "strict", "recommended", or "all"
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						-- Suppress missing type stub warnings for packages without .pyi files
						reportMissingTypeStubs = false,
					},
				},
			},
		})
		-- require("lspconfig").basedpyright.setup({
		-- 	capabilities = lspconfig_defaults.capabilities,
		-- 	settings = {
		-- 		python = {
		-- 			analysis = {
		-- 				-- ENABLE type checking (this was previously "off")
		-- 				typeCheckingMode = "standard", -- "basic", "standard", "strict", "recommended", or "all"
		-- 				autoSearchPaths = true,
		-- 				useLibraryCodeForTypes = true,
		-- 				-- Suppress missing type stub warnings for packages without .pyi files
		-- 				reportMissingTypeStubs = false,
		-- 			},
		-- 		},
		-- 	},
		-- })
		-- Setup Ruff (unchanged)
		require("lspconfig").ruff.setup({
			filetypes = { "python" },
			capabilities = lspconfig_defaults.capabilities,
			init_options = {
				settings = {
					-- Let basedpyright handle hover, Ruff focuses on linting/formatting
					hover = false,
					lint = {
						ignore = { "E401" },
					},
				},
			},
		})
		-- Get rid of the annoying 'Undefined global "vim"' error.
		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		-- Auto-format Python files with Ruff on save
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			pattern = "*.py",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
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
