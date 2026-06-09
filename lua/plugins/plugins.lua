-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "KeitaNakamura/tex-conceal.vim", event = "BufEnter *.tex" },
  { "matze/vim-tex-fold", event = "BufEnter *.tex" },
  { "ellisonleao/gruvbox.nvim" },
  { "maxmx03/solarized.nvim", lazy = false, priority = 1000, opts = {} },

  -- configure LazyVim to load Solarized Light
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },

  -- override the configuration of Copilot plugins
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       lua = true,
  --       help = true,
  --     },
  --   },
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = "copilot.lua",
  --   opts = {
  --     event = { "InsertEnter", "LspAttach" },
  --     fix_pairs = false,
  --   },
  --   config = function(_, opts)
  --     local copilot_cmp = require("copilot_cmp")
  --     copilot_cmp.setup(opts)
  --     -- attach cmp source whenever copilot attaches
  --     -- fixes lazy-loading issues with the copilot cmp source
  --     require("lazyvim.util").lsp.on_attach(function(client)
  --       if client.name == "copilot" then
  --         copilot_cmp._on_insert_enter({})
  --       end
  --     end)
  --   end,
  -- },

  { "normen/vim-pio" },
  { "andweeb/presence.nvim" },
}
