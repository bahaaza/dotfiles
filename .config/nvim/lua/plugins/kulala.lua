return {
  "mistweaverco/kulala.nvim",
  opts = {
    -- debug = true,
    -- curl_path = "/tmp/curl",
    additional_curl_options = { "--insecure" },
    certificates = {
      ["*.remcdndev.com"] = {
        cert = "/Users/bahaaz/work/secrets/.me8_dev_newItermediate/oem_admin.pem:aaaa",
        key = "/Users/bahaaz/work/secrets/.me8_dev_newItermediate/oem_admin.key",
      },
      ["*.remdevme.com"] = {
        cert = "/Users/bahaaz/.certs_dev/oem_admin.pem:aaaa",
        key = "/Users/bahaaz/.certs_dev/oem_admin.key",
      },
    },
  },
}
