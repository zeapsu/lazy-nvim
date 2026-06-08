return {
  "brianhuster/live-preview.nvim",
  cmd = { "LivePreview" },
  keys = {
    { "<leader>vp", "<cmd>LivePreview start<cr>", desc = "Start Live Preview" },
    { "<leader>vs", "<cmd>LivePreview stop<cr>", desc = "Stop Live Preview" },
  },
  opts = {
    port = 5500,
    browser = "default",
    sync_scroll = true,
    autokill = true,
  },
  config = function(_, opts)
    -- Initialize using setup
    require("livepreview").setup(opts)

    -- Auto-save on TextChanged/InsertLeave for HTML/CSS/JS files
    -- to enable real-time updates in the browser
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("LivePreviewAutoSave", { clear = true }),
      pattern = { "*.html", "*.css", "*.js" },
      callback = function()
        -- Only save if the buffer is modified
        if vim.bo.modified then
          vim.cmd("silent! write")
        end
      end,
    })
  end,
}
