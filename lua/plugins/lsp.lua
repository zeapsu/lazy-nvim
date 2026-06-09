return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          cmd = {
            "sh",
            "-c",
            'export JAVA_OPTS="-Djdk.xml.totalEntitySizeLimit=50000000 --enable-native-access=ALL-UNNAMED --sun-misc-unsafe-memory-access=allow $JAVA_OPTS"; exec ltex-ls "$@" 2>/dev/null',
            "--",
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
