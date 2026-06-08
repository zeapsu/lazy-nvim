return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          settings = {
            ltex = {
              ["ltex-ls"] = {
                logLevel = "severe",
              },
            },
          },
        },
      },
    },
  },
}
