return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
        },
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              userDictPath = vim.fn.stdpath("config") .. "/harper-user-dict.txt",
            },
          },
        },
      },
    },
  },
}
