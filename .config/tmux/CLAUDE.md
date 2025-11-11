# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a tmux configuration repository using the "Oh My Tmux!" framework (https://github.com/gpakosz/.tmux). The setup consists of:

- `tmux.conf` - Symlink to the Oh My Tmux! base configuration at `~/.local/share/tmux/oh-my-tmux/.tmux.conf`
- `tmux.conf.local` - User-specific customizations and overrides (this is the primary file to edit)
- `plugins/` - Directory managed by TPM (Tmux Plugin Manager) containing installed plugins

## Configuration Architecture

The configuration follows a two-file pattern:
1. **Base configuration** (`tmux.conf`) provides the Oh My Tmux! framework
2. **Local overrides** (`tmux.conf.local`) contains all user customizations

**Important**: Always edit `tmux.conf.local` for customizations, never modify the base `tmux.conf` as it's a symlink to the Oh My Tmux! framework.

## Plugin Management

This configuration uses TPM (Tmux Plugin Manager) for plugin management.

### Currently Installed Plugins
None currently active. The `christoomey/vim-tmux-navigator` plugin is commented out because it requires both tmux-side and vim/neovim-side configuration to work properly.

### Adding Plugins
1. Add plugin declaration to `tmux.conf.local` using `set -g @plugin 'author/plugin-name'`
2. Reload tmux configuration: `tmux source ~/.config/tmux/tmux.conf.local`
3. Install plugins: `<prefix> + I` (capital I)

### TPM Key Bindings
- `<prefix> + I` - Install new plugins
- `<prefix> + U` - Update plugins
- `<prefix> + Alt + u` - Uninstall removed plugins

## Custom Key Bindings

The following custom bindings are configured in `tmux.conf.local`:

### Pane Navigation (lines 467-470)
- `Ctrl+h` - Move to left pane
- `Ctrl+j` - Move to pane below
- `Ctrl+k` - Move to pane above
- `Ctrl+l` - Move to right pane

### Window and Pane Management
- `<prefix> + "` - Split window vertically in current directory
- `<prefix> + %` - Split window horizontally in current directory
- `<prefix> + c` - Create new window in current directory
- `<prefix> + \` - Create 3-pane layout (top pane + 2 bottom panes split horizontally)
- `<prefix> + m` - Toggle mouse mode with status message

**Note**: The `#!important` marker on the Ctrl+hjkl bindings ensures Oh My Tmux! won't override them.

## Testing Configuration Changes

After editing `tmux.conf.local`:

```bash
# Reload configuration in running tmux session
tmux source ~/.config/tmux/tmux.conf.local
```

Or from within tmux: `<prefix> + :` then type `source ~/.config/tmux/tmux.conf.local`

## Theme Customization

The theme is configured via `tmux_conf_theme_colour_*` variables in `tmux.conf.local`. The current theme uses a dark color scheme with:
- Blue highlights for active elements
- Yellow accents for status indicators
- Dark gray backgrounds

To modify theme colors, edit the `tmux_conf_theme_colour_1` through `tmux_conf_theme_colour_17` variables (lines 89-105).

## Configuration Variables

Key configurable behaviors in `tmux.conf.local`:
- `tmux_conf_new_pane_retain_current_path=true` - New panes open in current directory
- `tmux_conf_update_plugins_on_launch=true` - Auto-update plugins on tmux start
- `tmux_conf_copy_to_os_clipboard=false` - Clipboard integration setting

## Vim/Neovim Integration

If you want seamless navigation between Vim/Neovim splits AND tmux panes:

1. Uncomment the `vim-tmux-navigator` plugin line in `tmux.conf.local` (line 464)
2. Install the corresponding plugin in Vim/Neovim:
   - **Vim**: Add `Plugin 'christoomey/vim-tmux-navigator'` to `.vimrc`
   - **Neovim with lazy.nvim**: See plugin README for configuration
3. Comment out the simple Ctrl+hjkl bindings (lines 467-470)
4. Reload tmux configuration

The `vim-tmux-navigator` plugin requires BOTH tmux and vim/neovim plugins to work correctly. Without both sides configured, the key bindings won't function properly.
