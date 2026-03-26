-- molten-nvim — Jupyter kernel interaction inside Neovim
-- Guide: https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
--
-- IMAGE SUPPORT NOTE:
--   image.nvim (3rd/image.nvim) requires a Kitty-protocol-compatible terminal
--   (Kitty, WezTerm, Ghostty). If you switch to one, uncomment the image.nvim block
--   below, add "3rd/image.nvim" to `dependencies`, and set
--   vim.g.molten_image_provider = "image.nvim" in the init function.

return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- stay on v1.x to avoid breaking changes
    -- Molten is a remote plugin: UpdateRemotePlugins must run after install/update
    build = ":UpdateRemotePlugins",
    -- No image.nvim dependency unless you have a Kitty-compatible terminal.
    -- dependencies = { "3rd/image.nvim" },
    init = function()
      -- Use "none" until you have a Kitty-compatible terminal; then switch to "image.nvim"
      vim.g.molten_image_provider = "none"

      -- Max height of the output window (in lines)
      vim.g.molten_output_win_max_height = 20

      -- Show output immediately when cursor enters the cell
      vim.g.molten_auto_open_output = false

      -- Wrap long lines in the output window
      vim.g.molten_wrap_output = true

      -- Show virtual text with cell status (running / done / error)
      vim.g.molten_virt_text_output = true

      -- Virtual text above cell showing state
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      -- Init: pick kernel interactively, or auto-select from active venv
      { "<localleader>mi", ":MoltenInit<CR>", desc = "Molten: Init kernel (pick)" },
      {
        "<localleader>mp",
        function()
          -- Auto-init the kernel that matches the active virtual environment
          local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
          if venv ~= nil then
            local name = string.match(venv, "/.+/(.+)")
            vim.cmd(("MoltenInit %s"):format(name))
          else
            vim.cmd("MoltenInit python3")
          end
        end,
        desc = "Molten: Init kernel from venv",
      },

      -- Evaluate
      { "<localleader>me", ":MoltenEvaluateOperator<CR>", desc = "Molten: Evaluate operator" },
      { "<localleader>ml", ":MoltenEvaluateLine<CR>", desc = "Molten: Evaluate line" },
      { "<localleader>mr", ":MoltenReevaluateCell<CR>", desc = "Molten: Re-evaluate cell" },
      {
        "<localleader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        mode = "v",
        desc = "Molten: Evaluate visual selection",
      },

      -- Output window
      { "<localleader>mo", ":MoltenShowOutput<CR>", desc = "Molten: Show output" },
      { "<localleader>mh", ":MoltenHideOutput<CR>", desc = "Molten: Hide output" },
      { "<localleader>md", ":MoltenDelete<CR>", desc = "Molten: Delete cell" },

      -- Copy output to clipboard (requires pyperclip)
      { "<localleader>mc", ":MoltenCopyOutput<CR>", desc = "Molten: Copy output" },
    },
  },

  -- ─── image.nvim (OPTIONAL) ───────────────────────────────────────────────
  -- Uncomment this block AND the dependencies line above if you are using
  -- Kitty, WezTerm, or another Kitty-graphics-protocol terminal.
  --
  -- {
  --   "3rd/image.nvim",
  --   version = "1.1.0", -- pin for stability with molten
  --   opts = {
  --     backend = "kitty",              -- "kitty" | "ueberzugpp"
  --     integrations = {},              -- disable built-in integrations; molten manages its own
  --     max_width = 100,
  --     max_height = 12,
  --     max_height_window_percentage = math.huge,   -- required for correct molten sizing
  --     max_width_window_percentage = math.huge,
  --     window_overlap_clear_enabled = true,
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --   },
  -- },
}
