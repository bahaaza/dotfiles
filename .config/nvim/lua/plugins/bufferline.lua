return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>pw", "<Cmd>BufferLinePick<CR>", desc = "Pick a buffer" },
  },
  opts = {
    options = {
      -- always_show_bufferline = true,
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "underline",
      },
    },
  },
}
