local vault_path = os.getenv("OBSIDIAN_PATH")

return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- ft = "markdown",
	event = {
		"BufReadPre " .. vault_path .. "*.md",
		"BufNewFile " .. vault_path .. "*.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "Morphy",
				path = vault_path,
			},
		},
		follow_url_func = function(url)
			vim.inspect(vim.system({ "open", url }))
		end,
	},
}
