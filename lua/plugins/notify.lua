return {
	"rcarriga/nvim-notify",
	lazy = false, -- importante: se carga al inicio
	config = function()
		local notify = require("notify")

		notify.setup({
			stages = "fade_in_slide_out",
			timeout = 3000,
			background_colour = "#000000",
			render = "default",
			fps = 60,
			level = vim.log.levels.INFO,
			max_width = 60,
			max_height = 10,
		})

		-- Reemplaza vim.notify por notify.nvim
		vim.notify = notify
	end,
}
