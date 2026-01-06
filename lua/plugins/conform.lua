return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },

	opts = {
		-- 🔹 Formatear al guardar
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},

		-- 🔹 Qué formateador usar por filetype
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			json = { "jq" },
			sh = { "shfmt" },
		},
	},
}
