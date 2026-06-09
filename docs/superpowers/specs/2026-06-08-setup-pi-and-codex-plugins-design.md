# Design Specification: setup-pi-and-codex-plugins

## 1. Objective
Integrate the `pi.nvim` (AI coding assistant) and `codex.nvim` (Codex CLI companion) plugins into the user's LazyVim Neovim configuration. The keybindings must be carefully mapped to avoid any overlap or conflict with the existing `claudecode.nvim` (Claude Code) and other active plugins like `symbols-outline`.

## 2. Exploration & Requirements
- **`pi` CLI**: Located at `/opt/homebrew/bin/pi` (version `0.79.0`).
- **`codex` CLI**: Located at `/Users/andrypaez/.local/bin/codex` (version `0.137.0`).
- **Keymap Conflicts**:
  - `claudecode.nvim` uses the `<leader>a` prefix for keymaps such as `<leader>ac`, `<leader>af`, `<leader>as`, etc.
  - `symbols-outline` uses `<leader>cs`.
  - LazyVim uses the `<leader>c` namespace for standard LSP code actions.
- **Resolution**:
  - `pi.nvim` will map to `<leader>ap...` (Pi namespace).
  - `codex.nvim` will map to `<leader>ax...` (Codex namespace).

## 3. Architecture & Components

### 3.1 `pi.nvim` Configuration
Create `lua/plugins/pi.lua` to manage setup:
- Plugin: `"pablopunk/pi.nvim"`
- Keymaps:
  - `<leader>ap` -> `:PiAsk` (Normal Mode) / `:PiAskSelection` (Visual Mode)
  - `<leader>apc` -> `:PiCancel` (Normal Mode)
  - `<leader>apl` -> `:PiLog` (Normal Mode)
- Configuration option `binary` set to `"/opt/homebrew/bin/pi"`.

### 3.2 `codex.nvim` Configuration
Create `lua/plugins/codex.lua` to manage setup:
- Plugin: `"ishiooon/codex.nvim"`
- Keymaps:
  - `<leader>ax` -> `:Codex` (Normal Mode)
  - `<leader>axf` -> `:CodexFocus` (Normal Mode)
  - `<leader>axs` -> `:CodexSend` (Visual Mode) / `:CodexTreeAdd` (Normal Mode for file trees like `neo-tree`, `oil`, etc.)
- Configuration option `terminal_cmd` set to `"/Users/andrypaez/.local/bin/codex"`.

## 4. Implementation Plan
- Step 1: Create `lua/plugins/pi.lua` with the designated configuration and keymaps.
- Step 2: Create `lua/plugins/codex.lua` with the designated configuration, binary path, and keymaps.
- Step 3: Run Neovim non-interactively or start it up to trigger plugin downloading/installation via `lazy.nvim`.
- Step 4: Verify that both plugins load properly and the keymaps trigger the respective commands without errors.
