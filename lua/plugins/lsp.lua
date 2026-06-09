return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          cmd_env = {
            JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=50000000",
          },
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
