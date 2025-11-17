# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Overview

This is a modular Neovim configuration based on kickstart-modular.nvim. It uses Lazy.nvim as the plugin manager and follows a modular architecture with plugins organized in separate files.

## Key Files and Architecture

### Core Configuration Structure
- `init.lua` - Main entry point that loads all other modules
- `lua/options.lua` - Vim options and settings
- `lua/keymaps.lua` - Custom keymaps and autocommands
- `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager bootstrap
- `lua/lazy-plugins.lua` - Plugin loading configuration

### Plugin Organization
- `lua/kickstart/plugins/` - Core plugins from kickstart.nvim
- `lua/custom/plugins/` - User-added custom plugins
- Plugins are loaded via `require()` statements or `{ import = "custom.plugins" }`

### Custom Plugins
The configuration includes several custom plugins in `lua/custom/plugins/`:
- `dadbod.lua` - Database management
- `dbt-lsp.lua` - Custom dbt LSP server (loads after main lspconfig via dummy plugin pattern)
- `dbtpal.lua` - dbt (data build tool) support
- `dotenv.lua` - Environment variable management
- `gruvbox.lua` - Gruvbox color scheme
- `lsp_signature.lua` - LSP signature help
- `markdown_preview.lua` - Markdown preview functionality
- `neoclip.lua` - Clipboard manager
- `oil.lua` - File explorer
- `sqlua.lua` - SQL utilities

**Note on dbt-lsp**: This uses a dummy plugin specification pattern to ensure it loads after the main `lspconfig.lua`, guaranteeing that the `LspAttach` autocommand is registered before the dbt LSP server attaches to buffers. This ensures keybindings work correctly for dbt SQL files.

## Development Commands

### Code Formatting
- `stylua .` - Format Lua files using StyLua with the configuration in `stylua.toml`
- Configuration: 2 spaces indentation, 100 column width, Unix line endings

### Plugin Management
- `:Lazy` - Open Lazy.nvim plugin manager interface
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins

### Health Checks
- `:checkhealth` - Run Neovim health checks to diagnose issues

## Configuration Details

### Leader Keys
- Leader key: `<space>`
- Local leader key: `,`

### Python Configuration
- Python host program: `$HOME/.venv/bin/python3`
- Gruvbox contrast: hard

### Tab Settings
- Default: 4 spaces for most files
- Lua files: 2 spaces (auto-configured via autocmd)
- Smart indent enabled, no text wrapping

### Key Features
- Relative line numbers enabled
- Persistent undo history
- Live substitution preview
- Highlight on yank
- Custom clipboard operations (leader+y for system clipboard)
- Arrow keys disabled in normal/insert modes (vim training wheels)
- Split navigation with Ctrl+hjkl

## Plugin Loading Pattern

Plugins are loaded using a modular approach:
1. Direct plugin specifications in `lazy-plugins.lua`
2. Individual plugin files in `kickstart/plugins/`
3. Bulk import from `custom/plugins/` directory

This allows for easy organization and maintenance of plugin configurations.