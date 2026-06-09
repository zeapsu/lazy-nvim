return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
