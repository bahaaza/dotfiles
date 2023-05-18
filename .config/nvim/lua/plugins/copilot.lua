-- add copilot
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "hrsh7th/cmp-copilot",
      dependencies = {
        "github/copilot.vim",
      },
    },
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend({ { name = "copilot" } }, opts.sources))
  end,
}
-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end
--
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     {
--       "zbirenbaum/copilot-cmp",
--       dependencies = {
--         "zbirenbaum/copilot.lua",
--       },
--       config = function()
--         require("copilot").setup({
--           suggestion = { enabled = true },
--           panel = { enabled = false },
--         })
--         require("copilot_cmp").setup({
--           formatters = {
--             label = require("copilot_cmp.format").format_label_text,
--             insert_text = require("copilot_cmp.format").format_insert_text,
--             preview = require("copilot_cmp.format").format_preview_text,
--           },
--         })
--       end,
--     },
--   },
--   opts = function(_, opts)
--     local cmp = require("cmp")
--     opts.sources = cmp.config.sources(vim.list_extend({ { name = "copilot", group_index = 2 } }, opts.sources))
--     -- This mapping is for copilot lua, it will break copilot vim which is commented above
--     opts.mapping["<CR>"] = cmp.mapping.confirm({
--       -- this is the important line
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = false,
--     })
--     opts.mapping["<Tab>"] = vim.schedule_wrap(function(fallback)
--       if cmp.visible() and has_words_before() then
--         cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--       else
--         fallback()
--       end
--     end)
--   end,
-- }
