return {
  {
    -- vim-rooter alternative
    -- Makes harpoon more usable
    "folke/tokyonight.nvim",
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        -- other configs
        on_colors = function(colors)
          colors.border = "#565f89"
        end,
      })
    end,
  },
}
