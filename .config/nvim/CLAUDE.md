# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modular Neovim configuration for **Neovim v0.11.2** (with LuaJIT 2.1.1748459687) using Lazy.nvim as the plugin manager. The repository contains two parallel configurations:
- **jrr**: Main configuration loaded by `init.lua`
- **ai**: Alternative configuration loaded by `ai.lua`

## Architecture

```
nvim/
├── init.lua         # Main entry (loads jrr config)
├── ai.lua          # Alternative entry (loads ai config)
├── lazy-lock.json  # Plugin version lock
└── lua/
    ├── ai/         # AI-specific configuration
    └── jrr/        # Main configuration
        ├── core/   # Core settings (init, keymaps, options)
        ├── lazy.lua # Plugin manager setup
        └── plugins/ # Individual plugin configs
            └── lsp/ # LSP-related plugins
```

## Key Commands

### Development Tasks
- **Update plugins**: Open Neovim and run `:Lazy update`
- **Install new plugin**: Add to appropriate file in `lua/[config]/plugins/`, then `:Lazy sync`
- **Check plugin status**: `:Lazy`
- **Mason package management**: `:Mason` to install/update LSPs, formatters, linters

### Common Operations
- **Switch between configurations**: Use `nvim -u ai.lua` for AI config, or just `nvim` for main config
- **Reload configuration**: `:source %` on current file or restart Neovim
- **Check health**: `:checkhealth` for plugin diagnostics

## Configuration Patterns

### Adding a New Plugin
Create a new file in `lua/[config]/plugins/` following this pattern:
```lua
return {
  "author/plugin-name",
  dependencies = { "dependency/name" },
  config = function()
    require("plugin-name").setup({
      -- configuration options
    })
    -- Add keymaps here
    vim.keymap.set("n", "<leader>xx", function() ... end, { desc = "Description for which-key" })
  end,
}
```

### LSP Setup
LSPs are managed through Mason. To add a new language server:
1. Add the server name to `ensure_installed` in `lua/[config]/plugins/lsp/mason.lua`
2. Configure the server in `lua/[config]/plugins/lsp/lspconfig.lua`

### Key Conventions
- Leader key is set to space
- All keymaps should include a `desc` field for which-key integration
- Plugin configs return a table with the plugin specification
- Use lazy loading where appropriate with `event`, `cmd`, or `ft` options

## Important Notes
- The configuration uses Tokyo Night colorscheme
- AI features are configured with Avante.nvim using OpenAI's gpt-4o model
- Auto-session is enabled for workspace persistence
- The configuration includes comprehensive LSP support for TypeScript, Python, Lua, and other languages