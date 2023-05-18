-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.env.PYENV_ROOT then
  vim.g.python3_host_prog = os.getenv("HOME") .. "/.pyenv/versions/neovim/bin/python"
end
