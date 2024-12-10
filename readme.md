- catppuccin color scheme
- leader key = " "
- lazy plugin manager
- treesitter for syntax highlighting
- telescope for fuzzy finding
- nvim-tree for file tree
- lsp for language server (Mason)
- autocompletion
- github copilot
- yank to system clipboard
- run Black PEP8 linter on python files on save
- alpha.nvim for startup screen

more colorschemes
lua linter (like Black)

### Debugging
- make sure the default lua is either lua5.1 or (more likely) luajit. NOT lua5.4
- sudo apt remove luarocks && sudo apt install luajit && ln -s /usr/bin/luajit /usr/local/bin/lua
