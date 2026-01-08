-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   branch = "v3.x",
--
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",
--     "MunifTanjim/nui.nvim",
--   },
--
--   cmd = "Neotree",
--
--   keys = {
--     { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
--   },
--
--   config = function()
--     require("neo-tree").setup({
--       close_if_last_window = true,
--       popup_border_style = "rounded",
--
--       filesystem = {
--         follow_current_file = {
--           enabled = true,
--         },
--         hijack_netrw_behavior = "open_current",
--       },
--
--       window = {
--         position = "left",
--         width = 36,
--         preserve = true,
--       },
--     })
--   end,
-- }

-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- iconos bonitos
		"MunifTanjim/nui.nvim",
	},
	keys = {
		-- ATAJO PRINCIPAL: Toggle + foco inteligente
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({
					toggle = true, -- Si está abierto → foco, si está cerrado → abre
					dir = vim.uv.cwd(), -- Abre en el directorio actual del proyecto
				})
			end,
			desc = "NeoTree: toggle y foco",
			mode = "n",
		},

		-- ATAJO EXTRA: Revela el archivo actual en Neo-Tree (muy útil)
		{
			"<leader>o",
			function()
				require("neo-tree.command").execute({
					reveal = true, -- Abre (si está cerrado) y selecciona el archivo actual
					dir = vim.uv.cwd(),
				})
			end,
			desc = "NeoTree: revelar archivo actual",
			mode = "n",
		},
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false, -- No cierra Neovim si Neo-Tree es la última ventana
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,

			filesystem = {
				follow_current_file = {
					enabled = true, -- Neo-Tree sigue automáticamente el archivo que editás
					leave_files_open = false,
				},
				hijack_netrw_behavior = "open_current", -- Reemplaza netrw completamente
				use_libuv_file_watcher = true, -- Actualiza en tiempo real
			},

			window = {
				position = "left",
				width = 36,
				mappings = {
					-- Navegación dentro de Neo-Tree (más intuitiva)
					["<cr>"] = "open", -- Enter abre archivo o carpeta
					["l"] = "open",
					["h"] = "close_node",
					["<esc>"] = "revert_preview",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["R"] = "refresh",
					["?"] = "show_help",
					["q"] = "close_window", -- q cierra Neo-Tree
				},
			},

			default_component_configs = {
				indent = {
					with_markers = true,
					indent_size = 2,
				},
				git_status = {
					symbols = {
						added = "✚",
						modified = "",
						deleted = "✖",
						untracked = "",
					},
				},
			},
		})
	end,
}
