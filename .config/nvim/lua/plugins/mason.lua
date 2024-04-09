return {

  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "flake8",
      "bash-language-server",
      "autopep8",
      "stylua",
      "dockerfile-language-server",
      "docker-compose-language-service",
      "lua-language-server",
      "yaml-language-server",
      "typescript-language-server",
      "eslint-lsp",
      "json-lsp",
      "terraform-ls"
    },
  },
}
