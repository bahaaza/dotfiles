-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-Right>", "<C-w><Right>")
vim.keymap.set("n", "<C-Left>", "<C-w><Left>")
vim.keymap.set("n", "<C-Up>", "<C-w><Up>")
vim.keymap.set("n", "<C-Down>", "<C-w><Down>")

-- vim.keymap.set("n", "<leader><Right>", "<C-w><Right>")
-- vim.keymap.set("n", "<leader><Left>", "<C-w><Left>")
-- vim.keymap.set("n", "<leader><Up>", "<C-w><Up>")
-- vim.keymap.set("n", "<leader><Down>", "<C-w><Down>")

-- Copy to system clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
