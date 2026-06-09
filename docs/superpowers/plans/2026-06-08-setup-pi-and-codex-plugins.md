# Pi and Codex Plugins Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Install and configure the `pi.nvim` and `ishiooon/codex.nvim` plugins in LazyVim with conflict-free keybindings.

**Architecture:** Create individual specification files for `lazy.nvim` under `lua/plugins/pi.lua` and `lua/plugins/codex.lua` to declare dependencies, config options, lazy command loading, and custom non-conflicting keymaps.

**Tech Stack:** Neovim, Lua, lazy.nvim, snacks.nvim

---

### Task 1: Configure `pi.nvim`

**Files:**
- Create: `lua/plugins/pi.lua`

- [ ] **Step 1: Create the plugin spec for `pi.nvim`**
  Create the file `lua/plugins/pi.lua` with the following contents:
  ```lua
  return {
    {
      "pablopunk/pi.nvim",
      dependencies = { "folke/snacks.nvim" },
      cmd = { "PiAsk", "PiAskSelection", "PiCancel", "PiLog" },
      keys = {
        { "<leader>ap", "<cmd>PiAsk<cr>", desc = "Ask Pi" },
        { "<leader>ap", ":PiAskSelection<cr>", mode = "v", desc = "Ask Pi (selection)" },
        { "<leader>apc", "<cmd>PiCancel<cr>", desc = "Cancel active Pi request" },
        { "<leader>apl", "<cmd>PiLog<cr>", desc = "Open Pi session log" },
      },
      opts = {
        binary = "/opt/homebrew/bin/pi",
      },
    }
  }
  ```

- [ ] **Step 2: Run syntax verification using `luac`**
  Run: `luac -p lua/plugins/pi.lua`
  Expected: No output (exits with code 0).

- [ ] **Step 3: Commit the changes**
  Run:
  ```bash
  git add lua/plugins/pi.lua
  git commit -m "feat: configure pi.nvim plugin"
  ```

---

### Task 2: Configure `codex.nvim`

**Files:**
- Create: `lua/plugins/codex.lua`

- [ ] **Step 1: Create the plugin spec for `codex.nvim`**
  Create the file `lua/plugins/codex.lua` with the following contents:
  ```lua
  return {
    {
      "ishiooon/codex.nvim",
      dependencies = { "folke/snacks.nvim" },
      cmd = { "Codex", "CodexFocus", "CodexSend", "CodexTreeAdd" },
      keys = {
        { "<leader>ax", "<cmd>Codex<cr>", desc = "Toggle Codex" },
        { "<leader>axf", "<cmd>CodexFocus<cr>", desc = "Focus Codex" },
        { "<leader>axs", "<cmd>CodexSend<cr>", mode = "v", desc = "Send selection to Codex" },
        { "<leader>axs", "<cmd>CodexTreeAdd<cr>", desc = "Add file to Codex", ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" } },
      },
      opts = {
        terminal_cmd = "/Users/andrypaez/.local/bin/codex",
      },
    }
  }
  ```

- [ ] **Step 2: Run syntax verification using `luac`**
  Run: `luac -p lua/plugins/codex.lua`
  Expected: No output (exits with code 0).

- [ ] **Step 3: Commit the changes**
  Run:
  ```bash
  git add lua/plugins/codex.lua
  git commit -m "feat: configure codex.nvim plugin"
  ```

---

### Task 3: Trigger Plugin Installation and Verify

**Files:**
- Modify: `lazy-lock.json` (auto-modified by Neovim on lock)

- [ ] **Step 1: Run lazy sync to install the plugins**
  Run: `nvim --headless "+Lazy! sync" +qa`
  Expected: Starts Neovim, runs lazy sync, and exits successfully with zero return code.

- [ ] **Step 2: Verify Neovim startup has no errors**
  Run: `nvim --headless -c "messages" +qa`
  Expected: Command exits successfully and displays no startup/runtime errors in messages.

- [ ] **Step 3: Commit the lockfile update**
  Run:
  ```bash
  git add lazy-lock.json
  git commit -m "chore: update lazy-lock.json with new plugins" || true
  ```
