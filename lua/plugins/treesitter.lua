return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",  -- ¡Importante: usa el branch master!
    build = ":TSUpdate",
    lazy = false,

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "python",
          "rust",
          "json",
          "yaml",
          "html",
          "css",
          "markdown",
          "markdown_inline",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
