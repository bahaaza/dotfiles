return {
  "FabijanZulj/blame.nvim",
  Setup = function()
    require("blame").setup({
      format = function(blame)
        return string.format("%s %s %s", blame.author, blame.date, blame.summary)
      end,
    })
  end,
  keys = {
    { "<leader>tb", "<cmd>ToggleBlame<cr>", desc = "Toggle blame" },
  },
}
