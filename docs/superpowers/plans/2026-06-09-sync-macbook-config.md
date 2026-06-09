# Sync MacBook Config Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Port Neovim configuration changes from the `macbook` branch of the `zeapsu/lazy-nvim` repo to the local `/home/zeapsu/.config/nvim` setup, while keeping Linux-specific settings, renaming the remote branch to `macos`, and committing Linux updates onto a new `linux` branch.

**Architecture:** Initialize git locally if needed, checkout the new `linux` branch, rename remote `macbook` branch to `macos`, copy over the new specs/configs with portability modifications (dynamic PATH binaries, local keymaps and OSC 52 configuration preserved), and verify using Neovim headless execution.

**Tech Stack:** Neovim, Lua, lazy.nvim, git, bash

---

### Task 1: Branch Renaming and Local Git Setup

**Files:**
- Modify/Configure: `/home/zeapsu/.config/nvim` (local config directory)
- Modify/Checkout: `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim` (cloned repository)

- [ ] **Step 1: Rename the local `macbook` branch to `macos` in the cloned repo**
  Run the following command in the cloned scratch repository directory `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim`:
  ```bash
  git branch -m macbook macos
  ```
  Expected: Local branch renamed from `macbook` to `macos`.

- [ ] **Step 2: Push the new `macos` branch to remote origin**
  Run:
  ```bash
  git push origin macos
  ```
  Expected: Remote branch `macos` created on GitHub.

- [ ] **Step 3: Delete the old `macbook` remote branch**
  Run:
  ```bash
  git push origin --delete macbook
  ```
  Expected: Remote branch `macbook` deleted from GitHub.

- [ ] **Step 4: Initialize git in `/home/zeapsu/.config/nvim` (if it does not have a `.git` folder)**
  Run:
  ```bash
  git init
  ```
  Expected: Reinitialized/initialized git repository in `/home/zeapsu/.config/nvim`.

- [ ] **Step 5: Configure remote origin in `/home/zeapsu/.config/nvim`**
  Run:
  ```bash
  git remote add origin https://github.com/zeapsu/lazy-nvim.git || git remote set-url origin https://github.com/zeapsu/lazy-nvim.git
  ```
  Expected: Remote origin configured to track `zeapsu/lazy-nvim.git`.

- [ ] **Step 6: Checkout a new branch `linux` locally**
  Run:
  ```bash
  git checkout -b linux
  ```
  Expected: Switched to a new branch `linux`.

---

### Task 2: Copy New Plugin Specs & Configurations

**Files:**
- Create: `lua/plugins/codex.lua`
- Create: `lua/plugins/pi.lua`
- Create: `lua/plugins/live-preview.lua`
- Create: `lua/plugins/markdown-preview.lua`
- Create: `lua/plugins/molten.lua`
- Create: `lua/plugins/jupytext.lua`
- Create: `lua/plugins/python.lua`
- Create: `lua/plugins/lint.lua`
- Create: `lua/plugins/lsp.lua`
- Create: `.markdownlint.yaml`
- Create: `lua/plugins/.clang-format`
- Create: `docs/superpowers/plans/2026-06-08-setup-pi-and-codex-plugins.md`
- Create: `docs/superpowers/specs/2026-06-08-setup-pi-and-codex-plugins-design.md`

- [ ] **Step 1: Copy and adjust `codex.lua`**
  Copy `codex.lua` from `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/codex.lua` to `/home/zeapsu/.config/nvim/lua/plugins/codex.lua`. Modify the `terminal_cmd` to use `"codex"` from the system `PATH` instead of the hardcoded MacBook path.
  ```lua
  return {
    {
      "ishiooon/codex.nvim",
      dependencies = { "folke/snacks.nvim" },
      cmd = { "Codex", "CodexFocus", "CodexSend", "CodexTreeAdd" },
      keys = {
        { "<leader>ax", group = "codex" },
        { "<leader>axx", "<cmd>Codex<cr>", desc = "Toggle Codex" },
        { "<leader>axf", "<cmd>CodexFocus<cr>", desc = "Focus Codex" },
        { "<leader>axs", "<cmd>CodexSend<cr>", mode = "v", desc = "Send selection to Codex" },
        { "<leader>axs", "<cmd>CodexTreeAdd<cr>", desc = "Add file to Codex", ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" } },
      },
      opts = {
        terminal_cmd = "codex",
      },
    }
  }
  ```

- [ ] **Step 2: Copy and adjust `pi.lua`**
  Copy `pi.lua` from `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/pi.lua` to `/home/zeapsu/.config/nvim/lua/plugins/pi.lua`. Modify the `binary` to use `"pi"` from the system `PATH` instead of any absolute paths.
  ```lua
  return {
    {
      "pablopunk/pi.nvim",
      cmd = { "PiAsk", "PiAskSelection", "PiCancel", "PiLog" },
      keys = {
        { "<leader>ap", group = "pi" },
        { "<leader>app", "<cmd>PiAsk<cr>", desc = "Ask Pi" },
        { "<leader>app", "<cmd>PiAskSelection<cr>", mode = "v", desc = "Ask Pi (selection)" },
        { "<leader>apc", "<cmd>PiCancel<cr>", desc = "Cancel active Pi request" },
        { "<leader>apl", "<cmd>PiLog<cr>", desc = "Open Pi session log" },
      },
      opts = {
        binary = "pi",
      },
    }
  }
  ```

- [ ] **Step 3: Copy `live-preview.lua`**
  Copy `live-preview.lua` from `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/live-preview.lua` to `/home/zeapsu/.config/nvim/lua/plugins/live-preview.lua`.

- [ ] **Step 4: Copy `markdown-preview.lua`**
  Copy `markdown-preview.lua` from `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/markdown-preview.lua` to `/home/zeapsu/.config/nvim/lua/plugins/markdown-preview.lua`.

- [ ] **Step 5: Copy `molten.lua` and `jupytext.lua`**
  Copy `molten.lua` and `jupytext.lua` from the cloned scratch repository's `lua/plugins/` directory to `/home/zeapsu/.config/nvim/lua/plugins/`.

- [ ] **Step 6: Copy `python.lua`**
  Copy `python.lua` from the cloned scratch repository's `lua/plugins/` directory to `/home/zeapsu/.config/nvim/lua/plugins/`.

- [ ] **Step 7: Copy `lint.lua` and `lsp.lua`**
  Copy `lint.lua` and `lsp.lua` from the cloned scratch repository's `lua/plugins/` directory to `/home/zeapsu/.config/nvim/lua/plugins/`.

- [ ] **Step 8: Copy formatting/lint configuration files**
  Copy `.markdownlint.yaml` from `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/.markdownlint.yaml` to `/home/zeapsu/.config/nvim/.markdownlint.yaml`.
  Copy `.clang-format` from `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/.clang-format` to `/home/zeapsu/.config/nvim/lua/plugins/.clang-format`.

- [ ] **Step 9: Copy design specification files**
  Copy `docs/superpowers/plans/2026-06-08-setup-pi-and-codex-plugins.md` and `docs/superpowers/specs/2026-06-08-setup-pi-and-codex-plugins-design.md` from the cloned scratch repository to `/home/zeapsu/.config/nvim/`.

---

### Task 3: Merge Config Files and Preserve Linux Preferences

**Files:**
- Modify: `lazyvim.json`
- Modify: `lua/config/options.lua`
- Modify: `lua/plugins/plugins.lua`
- Modify: `lua/plugins/claudecode.lua`

- [ ] **Step 1: Merge `lazyvim.json` extras**
  Modify `/home/zeapsu/.config/nvim/lazyvim.json` to append all MacBook extras while keeping your local `"lazyvim.plugins.extras.lang.yaml"`. The final `extras` block should look exactly like this:
  ```json
  {
    "extras": [
      "lazyvim.plugins.extras.lang.yaml",
      "lazyvim.plugins.extras.dap.core",
      "lazyvim.plugins.extras.editor.aerial",
      "lazyvim.plugins.extras.formatting.black",
      "lazyvim.plugins.extras.formatting.prettier",
      "lazyvim.plugins.extras.lang.clangd",
      "lazyvim.plugins.extras.lang.json",
      "lazyvim.plugins.extras.lang.markdown",
      "lazyvim.plugins.extras.lang.python",
      "lazyvim.plugins.extras.lang.rust",
      "lazyvim.plugins.extras.lang.tailwind",
      "lazyvim.plugins.extras.lang.tex",
      "lazyvim.plugins.extras.lang.typescript",
      "lazyvim.plugins.extras.linting.eslint",
      "lazyvim.plugins.extras.util.dot",
      "lazyvim.plugins.extras.util.mini-hipatterns"
    ],
    "install_version": 8,
    "news": {
      "NEWS.md": "11866"
    }
  }
  ```

- [ ] **Step 2: Update `lua/config/options.lua`**
  Modify `/home/zeapsu/.config/nvim/lua/config/options.lua` to ensure local settings (OSC 52 clipboard over SSH, opt.background = "light", etc.) are preserved, but uncomment or set `g.vimtex_view_method = "sioyek"`. The final file should end like:
  ```lua
  -- plugin options
  g.vimtex_view_method = "sioyek"

  -- Molten: point Neovim's remote plugin host at the dedicated venv
  -- (keeps pynvim/jupyter_client isolated from project venvs)
  g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
  ```

- [ ] **Step 3: Update `lua/plugins/plugins.lua`**
  Copy `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/plugins.lua` to `/home/zeapsu/.config/nvim/lua/plugins/plugins.lua`. Verify that colorscheme option points to `solarized` and the other plugins (vim-pio, presence.nvim) are present.

- [ ] **Step 4: Update `lua/plugins/claudecode.lua`**
  Copy `/home/zeapsu/.gemini/antigravity-cli/brain/0d0b6c05-67a2-41f7-99d9-7f67fef8328e/scratch/lazy-nvim/lua/plugins/claudecode.lua` to `/home/zeapsu/.config/nvim/lua/plugins/claudecode.lua`.

---

### Task 4: Verify and Test the Merged Setup

**Files:**
- None (Headless execution check)

- [ ] **Step 1: Check Lua syntax on all copied/modified files**
  Run:
  ```bash
  find /home/zeapsu/.config/nvim/lua -name "*.lua" -exec luac -p {} +
  ```
  Expected: Exits with 0 and no output (meaning no syntax errors).

- [ ] **Step 2: Run Lazy sync to install new plugins**
  Run:
  ```bash
  nvim --headless "+Lazy! sync" +qa
  ```
  Expected: Starts Neovim, installs new dependencies, and exits successfully with 0.

- [ ] **Step 3: Verify Neovim loads without startup errors**
  Run:
  ```bash
  nvim --headless -c "messages" +qa
  ```
  Expected: Command exits successfully with 0 and prints no plugin configuration or runtime warnings/errors.

---

### Task 5: Commit and Push Changes to `linux` Branch

**Files:**
- Modify/Commit: `/home/zeapsu/.config/nvim`

- [ ] **Step 1: Stage all synced and modified files**
  Run:
  ```bash
  git add .
  ```
  Expected: Files staged for commit.

- [ ] **Step 2: Commit the synced configuration**
  Run:
  ```bash
  git commit -m "feat(linux): sync configurations from macbook branch with linux overrides"
  ```
  Expected: Local commit created successfully.

- [ ] **Step 3: Push the new branch to GitHub**
  Run:
  ```bash
  git push -u origin linux
  ```
  Expected: `linux` branch pushed and upstream set.
