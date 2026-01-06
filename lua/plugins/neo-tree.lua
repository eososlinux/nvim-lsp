return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  cmd = "Neotree",

  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
  },

  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",

      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_current",
      },

      window = {
        position = "left",
        width = 36,
      },
    })
  end,
}
