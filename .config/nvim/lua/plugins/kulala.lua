return {
  "mistweaverco/kulala.nvim",
  opts = {
    debug = true,
    default_env = "local",
    winbar = true,
    -- curl_path = "/tmp/curl",
    additional_curl_options = { "--ipv4", "--insecure" },
    certificates = {
      ["*.remcdndev.com"] = {
        cert = "/Users/bahaaz/work/secrets/.me8_dev_newItermediate/oem_admin.pem:aaaa",
        key = "/Users/bahaaz/work/secrets/.me8_dev_newItermediate/oem_admin.key",
      },
      ["*.remdevme.com"] = {
        cert = "/Users/bahaaz/.certs_dev/oem_admin.pem:aaaa",
        key = "/Users/bahaaz/.certs_dev/oem_admin.key",
      },
      ["*.remtiles.com"] = {
        cert = "/Users/bahaaz/work/secrets/prod_oem/oem_admin.pem:rpJov8HAYIGg1D7",
        key = "/Users/bahaaz/work/secrets/prod_oem/oem_admin.key",
      },
    },
  },
}
