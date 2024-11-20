

return {
   -- Lazy load Catppuccin color scheme
   {
     'catppuccin/nvim',
     name = 'catppuccin',
     priority = 1000,  -- Ensures this theme loads first if present
     cmd = 'Catppuccin',  -- Load when this command is executed
     config = function()
       vim.cmd('colorscheme catppuccin')  -- Set color scheme when loaded
     end,
   },

   -- Lazy load Kanagawa color scheme
   {
     'rebelot/kanagawa.nvim',
     cmd = 'Kanagawa',  -- Load when this command is executed
     config = function()
       vim.cmd('colorscheme kanagawa')  -- Set color scheme when loaded
     end,
   },

   -- Lazy load Tokyo Night color scheme
   {
     'folke/tokyonight.nvim',
     cmd = 'Tokyonight',  -- Load when this command is executed
     config = function()
       vim.cmd('colorscheme tokyonight')  -- Set color scheme when loaded
     end,
   },
}

