return {
  -- Tus plugins mason, etc.
  { import = "plugins.mason" },
  { import = "plugins.treesitter" },

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,     -- Carga inmediatamente
    priority = 1000,  -- Alta prioridad
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- O si usas otro (catppuccin, gruvbox, etc.), cámbialo
}
