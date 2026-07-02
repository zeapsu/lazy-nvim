return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        -- Tab: accept Copilot ghost text first, then snippet jump,
        -- then accept the menu selection, else insert a tab.
        ["<Tab>"] = {
          LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "select_and_accept",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<CR>"] = { "fallback" },
      },
    },
  },
}
