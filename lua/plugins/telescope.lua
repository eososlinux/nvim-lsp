return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",

	dependencies = {
		"nvim-lua/plenary.nvim",

		-- Opcional pero MUY recomendado (más rápido)
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},

	cmd = "Telescope",

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "❯ ",
				path_display = { "smart" },

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist,
						["<Esc>"] = actions.close,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},

			pickers = {
				find_files = {
					hidden = true,
				},
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- Cargar extensión fzf (si está instalada)
		pcall(telescope.load_extension, "fzf")
	end,
}
