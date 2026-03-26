return {
  "GCBallesteros/jupytext.nvim",
  lazy = false, -- Must be false so it can intercept .ipynb files immediately on load
  opts = {
    style = "percent", -- Converts notebook cells into standard `# %%` Python blocks
    output_extension = "py", -- Forces the output to be treated as a pure Python file
    force_ft = "python", -- Tells your LSP (like Pyright/Ruff) to treat the buffer as Python
  },
}
