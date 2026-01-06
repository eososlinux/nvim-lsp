-- ~/.config/chad/lua/plugins/mason.lua
return {
	-- Mason principal
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" }, -- lazy load
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Puente entre Mason y el LSP nativo de Neovim
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local mlsp = require("mason-lspconfig")

			mlsp.setup({
				ensure_installed = {
					"lua_ls",
					"basedpyright",
					"ruff",
					"rust_analyzer",
				},
				automatic_installation = true,
			})

			-- Neovim 0.10+: habilitar LSPs directamente
			for _, server in ipairs(mlsp.get_installed_servers()) do
				vim.lsp.enable(server)
			end
		end,
	},
}
