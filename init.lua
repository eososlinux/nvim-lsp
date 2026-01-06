-- ~/.config/chad/init.lua
-- Bootstrap lazy.nvim
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

-- Carga tus plugins
require("lazy").setup("plugins")

-- Tus otras configs (lsp nativo, keymaps, options, etc.)
require("config.lsp") -- por ejemplo, tu lsp.lua anterior
-- ... otras requires si las tienes
--
require("config.lsp")
require("config.options")
require("config.globals")
require("config.keymap")
require("config.autocmd")
require("config.colorscheme")
require("plugins.init")
