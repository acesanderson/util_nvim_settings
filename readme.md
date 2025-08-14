My neovim configs as of 2025-08-13. Prioritize python development.

## Core Setup

- **Leader key**: Space (`" "`) for both global and local leader
- **Plugin manager**: Lazy.nvim with performance optimizations (caching, disabled default plugins)
- **Python integration**: Automatic detection of `.venv/bin/python` in project directories via `env.lua`

## Key Customizations

### Editor Options
- Line numbers with relative numbering
- Treesitter-based folding (disabled by default)
- Center cursor with `scrolloff = 999`
- System clipboard integration
- Smart split behavior (below/right)
- Concealment level 1 for cleaner markdown display

### Language Server Protocol (LSP)
- **Mason**: Automatic LSP server management
- **Python**: BasedPyright (type checking enabled) + Ruff (linting/formatting)
- **Other languages**: lua_ls, yamlls, sqlls
- **Auto-formatting**: Python files formatted with Ruff on save
- **Type checking**: Standard mode with missing type stubs suppressed

### Completion & UI
- **nvim-cmp**: LSP-based completion
- **Noice**: Enhanced UI for LSP documentation and notifications (0.5s timeout)
- **Which-key**: Keybinding hints
- **Bufferline**: Tab-like buffer management
- **Transparent**: Background transparency support

### File Management
- **Nvim-tree**: File explorer (disabled in Obsidian directories)
- **Telescope**: Fuzzy finder for files, grep, buffers, help
- **Obsidian**: Vault integration when `OBSIDIAN_PATH` environment variable is set

### Terminal & Tools
- **Toggleterm**: Floating terminal with `Ctrl+\`
- **Tmux navigator**: Seamless tmux pane navigation
- **Dadbod**: Database UI and completion

### Custom Commands
- **DocsGenerate**: Generates Python docstrings using external `docs` command
- **DocsGenerateAsync**: Async version of docstring generation
- **DocsShowContext**: Debug info for docstring generation
- **Docs**: Shorthand alias

### Key Mappings
- `<leader>d`: Show LSP diagnostics
- `<leader>t`: Toggle file tree
- `<leader>r`: Run current Python file in floating terminal
- `<leader>fj`: Format JSON with jq
- `<leader>st`: Format Lua with stylua
- `<leader>vp`: Show Python provider path
- Standard LSP bindings (hover, go-to-definition, references, etc.)

### Autocommands
- **Lua formatting**: Auto-format with stylua on save
- **Substitute shortcuts**: Very magic mode abbreviations (`%s/` → `%s/\v`)
- **Rainbow delimiters**: Colorized parentheses/brackets with colorscheme adaptation

### Syntax & Highlighting
- **Treesitter**: Syntax highlighting for Lua, Python, JavaScript, JSON, Bash, Markdown
- **Incremental selection**: Expand/contract selections with `<Leader>ss/si/sc/bd`
- **Text objects**: Function/class selection (`af/if/ac/ic`)
- **Parameter swapping**: `<Leader>a/A` for function arguments

### Color Schemes
- **Default**: Everforest
- **Available**: 20+ themes including Catppuccin, Tokyo Night, Gruvbox, Rose Pine
- **Custom schemes**: Three William Morris-inspired themes (morris, morris-botanical, picabia)
- **Theme management**: Lazy-loaded colorschemes with fallback to Catppuccin

### Development Tools
- **GitHub Copilot**: Code completion for multiple file types
- **Python execution**: Direct file running with `<leader>r`
- **Project root detection**: Smart detection using pyproject.toml, setup.py, .git, etc.

### Performance Optimizations
- Lazy loading for most plugins
- Conditional plugin loading (e.g., nvim-tree disabled in Obsidian)
- LSP log level set to "error"
- Disabled default Neovim plugins (gzip, netrw, etc.)
