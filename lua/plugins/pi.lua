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
      binary = "/opt/homebrew/bin/pi",
    },
  }
}
