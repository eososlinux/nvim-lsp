-- ~/.config/chad/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- SOLO esto para plugins
require("lazy").setup("plugins")

-- Configuración general (NO plugins)
require("config.lsp")
require("config.options")
require("config.globals")
require("config.keymap")
require("config.autocmd")
require("config.colorscheme")
require("config.diagnostics")
