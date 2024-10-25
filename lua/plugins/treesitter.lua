return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",  -- Add this line to include Python
        -- other languages you want to support
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- other configurations...
    })
  end,
}
