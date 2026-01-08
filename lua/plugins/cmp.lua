-- ~/.config/nvim/lua/plugins/cmp.lua
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- Carga solo al entrar en modo insert
	dependencies = {
		-- Fuentes de completado
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		-- Integración con snippets
		"saadparwaiz1/cmp_luasnip",

		-- Motor de snippets + colección popular
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				-- Carga todos los snippets de friendly-snippets (incluye excelentes para Python)
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			preselect = cmp.PreselectMode.None, -- No preselecciona nada automáticamente

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered(), -- Bordes en el menú de completado
				documentation = cmp.config.window.bordered(), -- Bordes en la documentación
			},

			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(), -- Forzar abrir menú
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				-- Confirmar solo si hay algo explícitamente seleccionado
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false, -- Importante: no confirma si no seleccionaste manualmente
				}),

				-- Tab y S-Tab inteligentes
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 }, -- Lo más inteligente primero
				{ name = "luasnip", priority = 750 },
				{ name = "path", priority = 500 },
				{ name = "buffer", priority = 250 },
			}),

			formatting = {
				format = function(entry, vim_item)
					-- Iconos simples según la fuente (opcional, pero bonito)
					local kind_icons = {
						nvim_lsp = "󰒋",
						luasnip = "󰘍",
						buffer = "󰈚",
						path = "󰉋",
					}
					vim_item.menu = kind_icons[entry.source.name] or ""
					return vim_item
				end,
			},
		})
	end,
}
