return
{
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup()
  end,
  keys = {
    { "<leader>tb", "<cmd>BlameToggle<cr>", desc = "Toggle blame" },
  },
}
