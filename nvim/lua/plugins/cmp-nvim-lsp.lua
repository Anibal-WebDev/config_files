return {
	{
		"hrsh7th/cmp-nvim-lsp",
		config = function()
			require('cmp').setup {
				sources = {
					{ name = 'nvim_lsp' },
				}
			}

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require('lspconfig').clangd.setup {
				capabilities = capabilities,
				config = {
					cmd = { "clangd", "--background-index" },
					filetypes = { "c", "cpp", "objc", "objcpp" },
					root_dir = function(fname)
						return root_pattern(fname) or vim.loop.os_homedir()
					end,
				},
			}

			require('lspconfig').bashls.setup {
				capabilities = capabilities,
			}

			require('lspconfig').pyright.setup {
				capabilities = capabilities,
				config = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
			}

			require('lspconfig').lua_ls.setup {
				capabilities = capabilities,
			}

			require('lspconfig').tsserver.setup {
				capabilities = capabilities,
			}

			--[[
			require('lspconfig').cssls.setup {
				capabilities = capabilities,
				config = {
					cmd = { "vscode-css-language-server", "--stdio" },
					filetypes = { "css", "scss", "less" },
					root_dir = function(fname)
						return root_pattern(fname) or vim.loop.os_homedir()
					end,
					settings = {
						css = {
							validate = true
						},
						less = {
							validate = true
						},
						scss = {
							validate = true
						}
					}
				}
			}
			]]
		end,
	},
}
