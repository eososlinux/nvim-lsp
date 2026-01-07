return {
  "akinsho/bufferline.nvim",
  version = "*",                                    -- usa la última versión estable
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- para iconos bonitos
  event = { "BufReadPre", "BufNewFile" },           -- carga cuando abres un buffer
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        -- Estilo de las pestañas
        mode = "buffers",                               -- muestra buffers (no tabs)
        style_preset = bufferline.style_preset.default, -- estilo clásico

        -- Numeración
        numbers = "none", -- opciones: "none" | "ordinal" | "buffer_id" | function
        -- numbers = function(opts) return string.format("%s", opts.id) end,

        -- Cerrar buffer con click medio o botón X
        close_command = "bdelete! %d",       -- cierra con :bdelete
        right_mouse_command = "bdelete! %d", -- click derecho también cierra
        middle_mouse_command = nil,          -- click medio desactivado

        -- Indicador visual
        indicator = {
          icon = "▎", -- icono del indicador (puedes usar "█" o "│")
          style = "icon",
        },

        -- Separadores y offsets
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",

        -- Nombre máximo y truncado
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,

        -- Diagnósticos LSP
        diagnostics = "nvim_lsp", -- muestra errores/warnings de LSP
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,

        -- Offset para sidebar como nvim-tree o neo-tree
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
          {
            filetype = "neo-tree",
            text = "Neo-Tree",
            text_align = "center",
            separator = true,
          },
        },

        -- Colores y highlights (se adapta a tu theme, como tokyonight)
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,

        -- Ordenamiento
        sort_by = "insert_after_current", -- opciones: 'id', 'extension', 'relative_directory', etc.
        separator_style = "thin",         -- "thick" | "thin" | "slope" | { 'any', 'any' }
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },

      -- -- Highlights opcionales (si quieres forzar colores)
      -- highlights = require("catppuccin.groups.integrations.bufferline").get({
      -- 	-- solo si usas catppuccin, sino borra esta línea y usa el theme automático
      -- }),
    })

    -- Keymaps útiles (opcional, pero recomendados)
    local map = vim.keymap.set
    map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Siguiente buffer" })
    map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Buffer anterior" })
    map("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Cerrar buffer actual" })
    map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin/Unpin buffer" })
    map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Cerrar otros buffers" })
  end,
}
