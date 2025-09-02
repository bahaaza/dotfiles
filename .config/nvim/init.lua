-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.env.PYENV_ROOT then
  vim.g.python3_host_prog = os.getenv("HOME") .. "/.pyenv/versions/neovim/bin/python"
end

if vim.env.NVM_DIR then
  -- local nvim_node_version = "v22.19.0"
  -- vim.g.node_host_prog = os.getenv("NVM_DIR") .. "/versions/node" .. nvim_node_version .. "/bin/node"
  vim.g.node_host_prog = io.open("nvm which default")
end
