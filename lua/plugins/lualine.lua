local function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if not clients or vim.tbl_isempty(clients) then
    return "  No LSP"
  end

  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  return "  " .. table.concat(names, ", ")
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,                                         -- ← importante: carga solo cuando lualine lo necesite
  event = { "VimEnter", "BufReadPost", "BufNewFile" }, -- carga temprana pero segura
  config = function()
    local lazy_status = require("lazy.status")         -- ahora SÍ está disponible

    require("lualine").setup({
      options = {
        -- theme = "auto",
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "alpha" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { lsp_status, "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          "location",
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              return " " .. lazy_status.stats().loaded .. "/" .. lazy_status.stats().total
            end,
            cond = lazy_status.has_updates or lazy_status.stats().pending > 0,
            color = { fg = "#a9a1e1" },
          },
        },
      },
    })
  end,
}
