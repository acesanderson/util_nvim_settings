return {
   'nvim-tree/nvim-tree.lua',
   cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },  -- Only loads on these commands
   keys = {                                               -- Or when shortcut is pressed
     { '<leader>t', ':NvimTreeFindFileToggle<CR>', desc = 'Toggle NvimTree' }
   }
 }

