-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "github/copilot.vim", lazy = false },
  { "KeitaNakamura/tex-conceal.vim", event = "BufEnter *.tex" },
  { "matze/vim-tex-fold", event = "BufEnter *.tex" },
}
