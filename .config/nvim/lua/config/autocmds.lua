-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_command("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
vim.api.nvim_command("autocmd BufNewFile,BufRead *.ddl set syntax=mysql")
vim.api.nvim_command("autocmd BufNewFile,BufRead *.nomad set ft=hcl")
vim.api.nvim_command("autocmd BufReadPost *.pb silent %!xxd")
-- vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
