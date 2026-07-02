return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          filetypes = {
            "asciidoc",
            "gitcommit",
            "mail",
            "markdown",
            "org",
            "pandoc",
            "plaintex",
            "quarto",
            "rmd",
            "rst",
            "tex",
            "text",
            "typst",
          },
          settings = {
            ["harper-ls"] = {
              userDictPath = vim.fn.stdpath("config") .. "/harper-user-dict.txt",
              linters = {
                -- Set to false to silence specific annoying linters
                SentenceCapitalization = false,
                SpellCheck = false,
                AvoidCurses = false,
              },
            },
          },
        },
      },
    },
  },
}
