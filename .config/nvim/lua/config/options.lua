-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.clipboard = ""
opt.relativenumber = true
vim.opt.colorcolumn = "120"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.conceallevel = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.g.autoformat = false -- globally
-- vim.b.autoformat = false -- buffer-local

-- vim.lsp.set_log_level("debug")

-- for copilot
local function SuggestOneCharacter()
  local suggestion = vim.fn["copilot#Accept"]("")
  local bar = vim.fn["copilot#TextQueuedForInsertion"]()
  return bar:sub(1, 1)
end
local function SuggestOneWord()
  local suggestion = vim.fn["copilot#Accept"]("")
  local bar = vim.fn["copilot#TextQueuedForInsertion"]()
  return vim.fn.split(bar, [[[ .]\zs]])[1]
end

local map = vim.keymap.set
map("i", "<M-n>", SuggestOneWord, { expr = true, remap = false })

vim.opt.wrap = true
