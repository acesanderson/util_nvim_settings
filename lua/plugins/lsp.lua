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

		-- Configure standard servers (excluding ty and ruff since they need custom config)
		local servers = {
			lua_ls = { filetypes = { "lua" } },
			yamlls = { filetypes = { "yaml", "yml" } },
			sqlls = { filetypes = { "sql" } },
		}

		-- Setup mason-lspconfig with python servers included in ensure_installed
		local ensure_installed = vim.list_extend(vim.tbl_keys(servers), {"ty", "ruff", "pyright"})
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_installation = false,
		})

		-- Setup standard LSP servers
		for server, config in pairs(servers) do
			lspconfig[server].setup({
				filetypes = config.filetypes,
				capabilities = lspconfig_defaults.capabilities,
			})
		end

		-- Python LSP setup (only once, when first Python file is opened)
		local python_lsp_setup = false
		
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function()
				if python_lsp_setup then
					return
				end
				python_lsp_setup = true

				-- Add custom configuration for Ty
				local configs = require('lspconfig.configs')

				if not configs.ty then
					configs.ty = {
						default_config = {
							cmd = { 'ty', 'server' },
							filetypes = { 'python' },
							root_dir = function(fname)
								return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
							end,
							settings = {},
						},
					}
				end

				-- Setup Pyright for navigation and completions
				require("lspconfig").pyright.setup({
					capabilities = lspconfig_defaults.capabilities,
					settings = {
						python = {
							analysis = {
								-- Disable Pyright's type checking since Ty handles that
								typeCheckingMode = "off",
								-- Keep other useful features
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							}
						}
					}
				})

				-- Setup Ty for fast type checking
				require('lspconfig').ty.setup({
					capabilities = lspconfig_defaults.capabilities,
				})

				-- Setup Ruff
				require("lspconfig").ruff.setup({
					filetypes = { "python" },
					capabilities = lspconfig_defaults.capabilities,
					init_options = {
						settings = {
							-- Let Ty handle hover, Ruff focuses on linting/formatting
							hover = false,
						}
					}
				})
			end,
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
