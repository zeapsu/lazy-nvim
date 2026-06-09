local function get_poetry_python()
  local util = require("lspconfig.util")

  -- Check if we're inside a Poetry project
  local pyproject = util.path.join(vim.loop.cwd(), "pyproject.toml")
  if vim.fn.filereadable(pyproject) == 1 then
    local handle = io.popen("poetry env info --path 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      local path = result:gsub("%s+", "") .. "/bin/python"
      if vim.fn.executable(path) == 1 then
        return path
      end
    end
  end

  -- fallback: nil = use system/default
  return nil
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = get_poetry_python(),
            },
          },
        },
      },
    },
  },
}
