 return {
   {
     'epwalsh/obsidian.nvim',
     version = '*',
     lazy = true,
     ft = 'markdown',
     enabled = function()
       return vim.fn.isdirectory('/Volumes/Capablanca/Morphy') == 1
     end,
     dependencies = {
       'nvim-lua/plenary.nvim',
     },
     opts = {
       workspaces = {
         {
           name = 'Morphy',
           path = '/Volumes/Capablanca/Morphy/'
         },
       },
     },
   },
   {
    -- pretty markdown
    'MeanderingProgrammer/render-markdown.nvim',
    -- enabled = false,
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  },
}
