return {
  "ravitemer/mcphub.nvim",
  -- commit = "8ff40b5edc649959bb7e89d25ae18e055554859a",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "Joakker/lua-json5",
  },
  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup({
      json_decode = require("json5").parse,
      workspace = {
        enabled = true, -- Default: true
        look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
        reload_on_dir_changed = true, -- Auto-switch on directory change
        port_range = { min = 40000, max = 41000 }, -- Port range for workspace hubs
        get_port = nil, -- Optional function for custom port assignment
      },
    })
    -- vim.notify("[MCPHub] Current working directory: " .. vim.fn.getcwd())
    -- Extend the default tools of code companion
    -- local code_companion_config = require("codecompanion.config")
    -- local default_tools = code_companion_config.interactions.chat.tools.opts.default_tools or {}
    --
    -- -- add sequentialthinking and context7 tools to default tools
    -- table.insert(default_tools, "sequentialthinking")
    -- table.insert(default_tools, "context7")
    -- vim.notify("[MCPHub] Added sequentialthinking and context7 tools to CodeCompanion default tools")
  end,
  keys = {
    { "<leader>am", "<cmd>MCPHub<cr>", desc = "Open MCP Hub" },
  },
}
