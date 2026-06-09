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
      terminal_cmd = vim.fn.expand("$HOME/.local/bin/codex"),
    },
  }
}
