-- /qompassai/Diver/lsp/basedpy_ls.lua
-- Qompass AI Based Pyright (BasedPy) LSP Config
-- Copyright (C) 2025 Qompass AI, All rights reserved
-----------------------------------------------------

local function set_python_path(command) ---@param command { args: string }
	local path = command.args
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "basedpyright",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, {
				pythonPath = path,
			})
		else
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
				python = {
					pythonPath = path,
				},
			})
		end
		client:notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { -- Corregido: quitamos la entrada inválida '[setup.py](http://setup.py)'
		".git",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
	},
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "workspace", -- Necesario para cargar builtins correctamente
				autoSearchPaths = true,
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,

				-- Importante: executionEnvironments vacío para evitar conflictos
				executionEnvironments = {},

				typeCheckingMode = "standard", -- Cambia a 'basic' si quieres menos estrictitud

				inlayHints = {
					callArgumentNames = true,
					callArgumentNamesMatching = true,
					functionReturnTypes = true,
					genericTypes = true,
					variableTypes = true,
				},

				logLevel = "Information",

				reportMissingImports = "none",
				reportMissingModuleSource = "none",
				-- Puedes añadir más reportes aquí si los quieres de vuelta
			},
			disableLanguageServices = false,
			disableOrganizeImports = false,

			python = {
				pythonPath = "/usr/bin/python3.13", -- Verifica que esta ruta exista en tu sistema
				version = "3.13", -- Fuerza la versión correcta de typeshed
			},
		},
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "BasedPyReanalyze", function()
			client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end, { desc = "Force basedpyright to re-read configuration" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
			local params = {
				command = "basedpyright.organizeimports",
				arguments = { vim.uri_from_bufnr(bufnr) },
			}
			client:request("workspace/executeCommand", params, nil, bufnr)
		end, { desc = "Organize Imports" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
			desc = "Reconfigure basedpyright python path",
			nargs = 1,
			complete = "file",
		})

		-- Formateo al guardar (corregido el filtro)
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(c)
							return c.name == "basedpyright"
						end,
					})
				end,
			})
		end
	end,
}
