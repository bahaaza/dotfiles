-- Configuration constants
local CONFIG = {
  MAX_RESPONSE_SIZE = 1024 * 1024, -- 1 MB
  DEFAULT_ENV = "local",
}

-- Safely load certificate configuration from external file
local function load_certificates()
  local HOME_DIR = os.getenv("HOME")
  local ok, certs_module = pcall(dofile, HOME_DIR .. "/work/secrets/kulala-certs.lua")
  if ok and certs_module and certs_module.get_certificates then
    return certs_module.get_certificates()
  else
    vim.notify(
      "Certificate configuration not found. Create nvim-certs.lua in ~/work/secrets/ to enable certificates.",
      vim.log.levels.WARN
    )
    return {} -- Return empty certificates if file doesn't exist
  end
end

return {
  "bahaaza/kulala.nvim",
  opts = {
    debug = true,
    default_env = CONFIG.DEFAULT_ENV,
    winbar = true,
    -- curl_path = "/tmp/curl",
    additional_curl_options = { "--ipv4", "--insecure" },
    certificates = load_certificates(),
    ui = {
      max_response_size = CONFIG.MAX_RESPONSE_SIZE,
    },
  },
}
