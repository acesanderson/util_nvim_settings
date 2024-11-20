return {
   'nvim-telescope/telescope.nvim',
   version = '0.1.8',  -- Specify the version if needed
   dependencies = {
     'nvim-lua/plenary.nvim', -- Required dependency
   },
   cmd = 'Telescope',
   keys = {
     { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
     { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
     { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
     { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
   },
   config = function()
     require('telescope').setup({
       -- your telescope config here if needed
     })
   end,
 }

