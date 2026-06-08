return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreview<cr>", ft = "markdown", desc = "Markdown Preview Open" },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", ft = "markdown", desc = "Markdown Preview Stop" },
  },
  config = function()
    -- Enable auto close of the browser tab when switching away or closing the buffer
    vim.g.mkdp_auto_close = 1
  end,
}
