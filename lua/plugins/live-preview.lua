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

    local lp = require("livepreview")
    local server_mod = require("livepreview.server")
    local ws = require("livepreview.server.websocket")
    local handler = require("livepreview.server.handler")

    -- List of active WebSocket client handles
    local active_websockets = {}

    -- 1. Safeguard WebSocket writes to prevent Neovim crashes on closed sockets
    local original_send = ws.send
    ws.send = function(client, message)
      if client:is_closing() then return end
      pcall(original_send, client, message)
    end

    -- 2. Explicitly clean up all sockets on server stop/close
    local original_close = lp.close
    lp.close = function()
      for _, client in ipairs(server_mod.connecting_clients) do
        if not client:is_closing() then
          client:close()
        end
      end
      server_mod.connecting_clients = {}
      active_websockets = {}
      original_close()
    end

    -- 3. Remove non-websocket HTTP requests from connecting_clients
    local original_request = handler.request
    handler.request = function(client, request)
      local res = original_request(client, request)
      if res then
        -- This is a normal HTTP request. Once served, it shouldn't receive reload updates.
        for i, c in ipairs(server_mod.connecting_clients) do
          if c == client then
            table.remove(server_mod.connecting_clients, i)
            break
          end
        end
      end
      return res
    end

    -- 4. Monitor active WebSockets to trigger auto-stop when all tabs are closed
    local original_handshake = ws.handshake
    ws.handshake = function(client, request)
      original_handshake(client, request)

      -- Add to our tracked active web sockets list
      table.insert(active_websockets, client)

      -- Start reading from the socket to detect connection closure (tab close)
      client:read_start(function(err, chunk)
        if err or not chunk then
          if not client:is_closing() then
            client:close()
          end

          -- Remove from server_mod.connecting_clients
          for i, c in ipairs(server_mod.connecting_clients) do
            if c == client then
              table.remove(server_mod.connecting_clients, i)
              break
            end
          end

          -- Remove from our active websockets list
          local found = false
          for i, c in ipairs(active_websockets) do
            if c == client then
              table.remove(active_websockets, i)
              found = true
              break
            end
          end

          -- If no active browser tabs are left, stop the server.
          -- Only trigger this if the closed connection was actively tracked.
          -- (If not found, it means active_websockets was already cleared by lp.close() on server stop/restart)
          if found and #active_websockets == 0 then
            vim.schedule(function()
              lp.close()
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
