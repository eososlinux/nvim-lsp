-- /qompassai/Diver/lsp/jsonls.lua

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.lsp.start({
			name = "jsonls",
			cmd = { "vscode-json-language-server", "--stdio" },

			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]) or vim.loop.cwd(),

			settings = {
				json = {
					validate = { enable = true },
					format = { enable = true },
					schemas = require("schemastore").json.schemas(),
				},
			},
		})
	end,
})
