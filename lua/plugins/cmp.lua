return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",

		-- Snippets
		"L3MON4D3/LuaSnip",
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- Cargar snippets por defecto (VSCode)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			preselect = cmp.PreselectMode.None,

			completion = {
				autocomplete = true,
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				-- Abrir completado manualmente
				["<C-Space>"] = cmp.mapping.complete(),

				-- Confirmar selección
				["<CR>"] = cmp.mapping.confirm({
					select = false, -- SOLO confirma si elegiste algo
				}),

				-- TAB: siguiente item / snippet / fallback
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				-- SHIFT+TAB: item previo / snippet atrás
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			}),

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					item.menu = ({
						nvim_lsp = "[LSP]",
						buffer = "[BUF]",
						path = "[PATH]",
						luasnip = "[SNIP]",
					})[entry.source.name]
					return item
				end,
			},
		})
	end,
}
