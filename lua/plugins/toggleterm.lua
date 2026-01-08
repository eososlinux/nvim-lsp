-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
	"akinsho/toggleterm.nvim",
	version = "*", -- siempre la última versión estable
	keys = { -- Carga lazy solo cuando uses estos atajos
		{ "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal horizontal" },
		{ "<leader>T", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal flotante" },
		{ "<leader>tg", "<cmd>ToggleTerm direction=horizontal name=lazygit cmd=lazygit<cr>", desc = "Lazygit" },
	},
	config = function()
		require("toggleterm").setup({
			size = 20, -- altura para horizontal, ancho para vertical
			open_mapping = [[<c-t>]], -- atajo global para toggle cualquier terminal
			hide_numbers = true, -- oculta números de línea en la terminal
			shade_terminals = true,
			shading_factor = 2, -- oscurece un poco el fondo
			start_in_insert = true, -- empieza en modo insert
			insert_mappings = true, -- permite mappings en modo insert
			persist_size = true,
			direction = "horizontal", -- default: horizontal, float, vertical, tab
			close_on_exit = true, -- cierra la terminal al salir del proceso
			shell = vim.o.shell, -- usa tu shell default (bash, zsh, fish, etc.)
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})
	end,
}
