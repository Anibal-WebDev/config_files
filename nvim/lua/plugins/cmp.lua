return {
	{
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-cmdline',
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = cmp.config.sources({
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'nvim_lua' },
					{ name = 'treesitter' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}),
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					["<A-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<A-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				}),
			})
		end,
	},
}
