return {
  "mistweaverco/kulala.nvim",
  opts = {
    -- debug = true,
    -- curl_path = "/tmp/curl",
    additional_curl_options = { "--insecure" },
    certificates = {
      ["*.example-dev.com"] = {
        cert = "/path/to/secrets/.me8_dev_newItermediate/oem_admin.pem:REDACTED_PASSWORD",
        key = "/path/to/secrets/.me8_dev_newItermediate/oem_admin.key",
      },
      ["*.example-dev2.com"] = {
        cert = "/path/to/certs/oem_admin.pem:REDACTED_PASSWORD",
        key = "/path/to/certs/oem_admin.key",
      },
    },
  },
}
