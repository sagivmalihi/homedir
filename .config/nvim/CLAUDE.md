# Neovim Configuration Guidelines

## Commands
- Plugin management: `:PackerSync` to install/update plugins
- Formatting: 
  - Auto-format on save for .js and .py files
  - Manual format with `:Neoformat`
  - Fix ESLint issues: `<leader>f`
- Building: `cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release` (telescope extension)
- Updates: `:TSUpdate` for Treesitter parser updates

## Code Style Guidelines
- Indentation: 2 spaces (tabstop=2, softtabstop=2, shiftwidth=2)
- Line length: No enforced limit, but prefer wrapping at 80-100 chars
- Naming: Use snake_case for variables and functions
- Comments: Use `--` for single line comments
- Error handling: Use vim.notify for user-facing messages
- LSP: Configuration for eslint, dockerls, cssls, jsonls, and ruff
- Lua globals: Configure with proper vim environment context

## Keybindings
- Leader key: `\` (backslash)
- `<leader>t` - find files
- `<leader>g` - grep search
- `<leader>f` - ESLint fix
- See remap.lua for complete key mappings