# Design Specification: sync-macbook-config

## 1. Objective
Port all recent configuration updates and features from the `macbook` branch of the `zeapsu/lazy-nvim` repository to the local Neovim setup at `/home/zeapsu/.config/nvim` on Linux. The execution must respect local OS-specific settings (like keeping Ctrl+J terminal toggle, local SSH clipboard settings) while successfully porting the new tools and plugins (e.g., molten, jupytext, codex, pi, live-preview, markdown-preview, and harper-ls).

## 2. Key Changes from MacBook Branch (24 Commits)
* **New Plugins Integrated:**
  * `pi.nvim` (AI coding assistant) mapped to `<leader>ap` namespace.
  * `codex.nvim` (Codex CLI companion) mapped to `<leader>ax` namespace.
  * `live-preview.nvim` (browser preview for HTML/CSS/JS with autosave and auto-stop when all tabs close) mapped to `<leader>v` namespace.
  * `markdown-preview.nvim` (markdown preview) mapped to `<leader>mp` and `<leader>ms`.
  * `molten-nvim` and `jupytext.nvim` (Jupyter kernel interactive notebook setup) mapped to `<localleader>m`.
  * `presence.nvim` (Discord rich presence) and `vim-pio` (PlatformIO).
* **LSP & Formatting Tweaks:**
  * Replaced `ltex-ls` with `harper-ls` in LSP config.
  * Configured `nvim-lint` to disable markdownlint `MD013` (line-length) rule globally via `.markdownlint.yaml`.
  * Added python poetry virtualenv auto-discovery for pyright.
* **Colorscheme:** Sets colorscheme to `solarized` using `solarized.nvim` (Light background).
* **Aider vs Claude Code:** Replaced Aider with `claudecode.nvim` on the MacBook branch to match the local setup.

## 3. Merging & Portability Architecture

### 3.1 Keymaps & Options (Linux Safeguards)
* **Terminal Toggle:** Maintain the local keymap mapping `<C-j>` (Ctrl+J) for terminal toggling (instead of the MacBook's macOS-specific `<D-j>` which maps to Cmd+J). Keep the `<C-`>` keymap for opening new terminal instances.
* **Clipboard over SSH:** Keep the local OSC 52 clipboard settings block in `lua/config/options.lua` to ensure clipboard redirection works seamlessly over SSH sessions. Keep `opt.clipboard = "unnamedplus"` and `opt.background = "light"`.
* **Path Portability:** For `pi.nvim` and `codex.nvim`, reference their executables directly by their command names (`"pi"` and `"codex"`) instead of hardcoding absolute homebrew/local paths. Neovim will resolve them dynamically from the system `PATH` on both Linux and macOS.

### 3.2 File sync map
1. **Copy directly (New Specs & Configs):**
   * `lua/plugins/codex.lua`
   * `lua/plugins/pi.lua`
   * `lua/plugins/live-preview.lua`
   * `lua/plugins/markdown-preview.lua`
   * `lua/plugins/molten.lua`
   * `lua/plugins/jupytext.lua`
   * `lua/plugins/python.lua`
   * `lua/plugins/lint.lua`
   * `lua/plugins/lsp.lua`
   * `.markdownlint.yaml`
   * `lua/plugins/.clang-format`
   * `docs/superpowers/plans/2026-06-08-setup-pi-and-codex-plugins.md`
   * `docs/superpowers/specs/2026-06-08-setup-pi-and-codex-plugins-design.md`
2. **Merge changes:**
   * **`lazyvim.json`:** Add new extras from MacBook config (dap, aerial, black, prettier, clangd, json, markdown, python, rust, tailwind, tex, typescript, eslint, dot, mini-hipatterns) while keeping `yaml` extra.
   * **`lua/config/options.lua`:** Keep local OSC 52, `opt.background = "light"`.
   * **`lua/plugins/plugins.lua`:** Port the colorscheme block, presence.nvim, and vim-pio configurations.
   * **`lua/plugins/claudecode.lua`:** Port the comments and layout from MacBook branch.
   * **`lua/config/keymaps.lua`:** Keep local `<C-j>` terminal toggle and keymaps.

### 3.3 Git Branching Strategy
* **Rename `macbook` to `macos`**: In the cloned repository, rename the branch `macbook` to `macos` both locally and on the remote origin (`zeapsu/lazy-nvim`).
* **Linux configuration branch**: Configure `/home/zeapsu/.config/nvim` to be a git repository pointing to `zeapsu/lazy-nvim`. Checkout a new local and remote branch called `linux` that is specialized for the Linux setup. Commit and push all merged updates onto this branch.

## 4. Verification Plan
* Validate all Lua syntax using `luac -p`.
* Launch Neovim in headless mode: `nvim --headless "+Lazy! sync" +qa` to download and install new plugins.
* Check Neovim startup logs for errors: `nvim --headless -c "messages" +qa`.

