# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modern Neovim configuration built for performance and developer productivity. The configuration supports both Neovim and VSCode environments with intelligent plugin loading and auto-discovery patterns.

## Architecture

### Core Structure
- `init.lua` - Entry point with filetype detection and lazy.nvim bootstrap
- `lua/config/lazy.lua` - Plugin manager setup with VSCode compatibility detection
- `lua/core/` - Core Neovim settings (options, keymaps, autocmds)
- `lua/plugins/` - Individual plugin configurations using lazy.nvim spec format
- `lua/utils/` - Shared utility functions (e.g., LSP auto-discovery)
- `after/lsp/` - LSP server-specific configurations

### Key Patterns

**Auto-Discovery LSP Pattern**: The configuration automatically discovers and enables LSP servers by scanning `after/lsp/` directory. Adding a new LSP server only requires:
1. Creating a new `.lua` file in `after/lsp/` with the server name
2. The `utils.lsp.get_available_lsp_servers()` function automatically detects it
3. Both Mason installation and LSP enabling happen automatically

**VSCode Compatibility**: Plugin loading is conditional based on `vim.g.vscode` detection. Some plugins are disabled in VSCode mode for optimal performance.

**Lazy Loading**: All plugins use lazy.nvim with specific trigger conditions (events, commands, filetypes) for fast startup times.

## Plugin Configuration Conventions

Each plugin file in `lua/plugins/` follows this structure:
```lua
return {
    {
        "author/plugin-name",
        event = "BufReadPost", -- or cmd, ft, etc.
        config = function()
            -- setup code
        end,
    },
}
```

## Language Support

The configuration includes LSP support for:
- **JavaScript/TypeScript**: Uses Biome for formatting, ts_ls for LSP
- **Python**: pylsp for LSP, ruff for linting/formatting  
- **Lua**: lua_ls with Neovim-specific configuration
- **Go, Terraform**: Server configs in `after/lsp/`
- **General**: typos_lsp for spell checking

Auto-formatting is enabled by default but disabled for TypeScript (uses external formatters).

## Key Components

**Completion**: Uses blink.cmp (high-performance completion engine) with GitHub Copilot integration.

**UI**: snacks.nvim provides unified notifications, statusline, and various UI components.

**Navigation**: Harpoon for file jumping, nvim-tree for file explorer, telescope for fuzzy finding.

**Git Integration**: gitsigns for git status in buffers, gitlinker for GitHub integration.

## Development Commands

**Formatting**: Code is automatically formatted on save. Lua files use stylua (config in `.stylua.toml`).

**LSP Management**: Use `:Mason` to install new language servers. Add corresponding config file in `after/lsp/` for automatic discovery.

**Plugin Management**: Use `:Lazy` to manage plugins. New plugins go in `lua/plugins/` directory.

## Extension Points

**Adding New LSP Server**:
1. Install via Mason (`:Mason`)
2. Create config file in `after/lsp/[server_name].lua`
3. Restart Neovim - auto-discovery handles the rest

**Adding New Plugin**:
1. Create new file in `lua/plugins/[plugin-name].lua`
2. Use lazy.nvim spec format
3. Consider VSCode compatibility if needed

**Shared Utilities**: Add reusable functions to `lua/utils/` with proper LSP-style type annotations using `---@` comments.