return {
  {
    "folke/snacks.nvim",
    opts = {},
    keys = {
      {
        "<leader>a",
        function()
          -- Gets the full path of the current buffer
          local file = vim.api.nvim_buf_get_name(0)

          -- Launches Aider in a floating terminal with the current file.
          -- You can append '--model claude-3-5-sonnet' or '--model o3-mini'
          -- if you want to force a specific subscription.
          Snacks.terminal.toggle("aider " .. file, {
            win = {
              position = "float",
              border = "rounded",
              width = 0.8,
              height = 0.8,
            },
          })
        end,
        desc = "Aider: Open with current file",
      },
    },
  },
}
