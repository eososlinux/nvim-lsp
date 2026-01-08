-- ~/.config/chad/lua/plugins/mason.lua
return {
	-- Mason principal
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
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

	-- Puente para LSPs (instalación automática)
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local mlsp = require("mason-lspconfig")
			mlsp.setup({
				ensure_installed = {
					"lua_ls",
					"basedpyright",
					"ruff", -- LSP para linting Python
					"rust_analyzer",
					"bashls", -- <-- Así se llama bash-language-server en lspconfig/nativo
					-- Agrega más LSPs aquí (nombres de lspconfig, ej: "pyright" si usas otro)
				},
				automatic_installation = true,
			})

			-- Activación nativa para servidores instalados
			for _, server in ipairs(mlsp.get_installed_servers()) do
				vim.lsp.enable(server)
			end
		end,
	},

	-- NUEVO: Para instalar tools NO-LSP como black, isort, etc.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black", -- Formateador Python
					"isort", -- Organizador de imports Python
					"stylua", -- Ejemplo Lua
					"prettier", -- Ejemplo web
					-- Agrega más: shellcheck, flake8, etc.
				},
				auto_update = true, -- Opcional: actualiza automáticamente
				run_on_start = true, -- Instala al iniciar Neovim si faltan
			})
		end,
	},
}
