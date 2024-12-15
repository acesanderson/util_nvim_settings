
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	enabled = function()
		local obsidian_path = os.getenv("OBSIDIAN_PATH")
		if not obsidian_path then
			return true -- If OBSIDIAN_PATH is not set, enable nvim-tree
		end

		local current_dir = vim.fn.expand("%:p:h")
		-- Check if current directory starts with OBSIDIAN_PATH
		return not vim.startswith(current_dir, obsidian_path)
	end,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeFindFileToggle",
	},
	keys = {
		{ "<leader>t", ":NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" },
	},
	init = function()
		-- Disable netrw
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = function()
		-- Enable 24-bit color
		vim.opt.termguicolors = true

		-- Reserve space in the gutter
		vim.opt.signcolumn = "yes"

		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				adaptive_size = true,
			},
			filters = {
				dotfiles = false,
			},
		})
	end,
}
