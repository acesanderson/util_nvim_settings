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
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "folke/tokyonight.nvim" },
  { "github/copilot.vim" },
  { "psf/black", branch = "stable" },
  { "nvim-tree/nvim-tree.lua" },
--  { "nvim-telescope/telescope.nvim", tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }},
  { "VonHeikemen/lsp-zero.nvim", branch = 'v4.x'},
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "bling/vim-bufferline" },
  -- Import all plugin configs I have in plugins folder
  { import = "plugins" },
  {
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
};
})

