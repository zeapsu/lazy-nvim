return {
  "brianhuster/live-preview.nvim",
  cmd = { "LivePreview" },
  keys = {
    { "<leader>vp", "<cmd>LivePreview start<cr>", desc = "Start Live Preview" },
    { "<leader>vs", "<cmd>LivePreview close<cr>", desc = "Stop Live Preview" },
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

    -- Monkeypatch WebSocket handshake to detect when browser tabs are closed
    local ws = require("livepreview.server.websocket")
    local original_handshake = ws.handshake
    ws.handshake = function(client, request)
      original_handshake(client, request)

      client:read_start(function(err, chunk)
        if err or not chunk then
          if not client:is_closing() then
            client:close()
          end

          local server_mod = require("livepreview.server")
          for i, c in ipairs(server_mod.connecting_clients) do
            if c == client then
              table.remove(server_mod.connecting_clients, i)
              break
            end
          end

          if #server_mod.connecting_clients == 0 then
            vim.schedule(function()
              require("livepreview").close()
              vim.notify("live-preview: All browser tabs closed. Server stopped.", vim.log.levels.INFO)
            end)
          end
        end
      end)
    end

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
