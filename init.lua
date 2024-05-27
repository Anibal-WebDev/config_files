vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.mouse = ""

vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{
		'neovim/nvim-lspconfig',
		'tpope/vim-fugitive',
		'AndreM222/copilot-lualine'
	},

	{
		'akinsho/toggleterm.nvim',
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<A-t>]],
				direction = "float",
				float_opts = {
					border = "curved",
					width = 100,
					height = 20,
					winblend = 3,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
				close_on_exit = true,
				shell = vim.o.shell,
			})
		end,
	},

	{

		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup({})
		end,
	},

	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'dracula',
					section_separators = { left = '', right = '' },
					component_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'selectioncount', 'tabs', 'filename' },
					lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}
		end
	},

	{
		'stevearc/conform.nvim',
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports", "gofmt" },
					javascript = { { "prettierd", "prettier" } },
					python = function(bufnr)
						if require("conform").get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format" }
						else
							return { "isort", "black" }
						end
					end,
					["*"] = { "codespell" },
					["_"] = { "trim_whitespace" },
				},
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},
				format_after_save = {
					lsp_fallback = true,
				},
			})
		end,
	},


	{
		"binhtran432k/dracula.nvim",
		lazy = false,
		priority = 1000,
		opts = {},

		config = function()
			require("dracula").setup({
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "transparent",
					floats = "transparent",
				},

			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				auto_close = true,
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
				view = {
					width = 30,
					side = "left",
					auto_resize = true,
				},
			})
		end,
	},

	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
		defaults = {
			layout_strategy = "vertical",
			layout_config = { height = 0.95 },
		},
	},

	{

		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },
				auto_install = true,

				ignore_install = {},
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
			}
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require('copilot').setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>"
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<Tab>",
						accept_word = false,
						accept_line = false,
						next = "<A-]>",
						prev = "<A-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = 'node', -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
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
		end,
	},
})

vim.cmd("colorscheme dracula")

local function map(m, k, v)
	vim.keymap.set(m, k, v)
end

-- Misc keymaps

map("n", "<A-n>", ":tabnew<CR>")
map("n", "<A-q>", ":q<CR>")
map("n", "<A-s>", ":w<CR>")
map("n", "<A-w>", ":wq<CR>")
map("n", "<A-%>", ":source %<CR>")
map("n", "<C-C>", ":e ~/.config/nvim/init.lua<CR>")

-- Move window keymaps

map("n", "<C-h>", "<C-w>H")
map("n", "<C-j>", "<C-w>J")
map("n", "<C-k>", "<C-w>K")
map("n", "<C-l>", "<C-w>L")

-- Resize window keymaps

map("n", "<A-j>", "<C-w>+5")
map("n", "<A-k>", "<C-w>-5")
map("n", "<A-h>", "<C-w><5")
map("n", "<A-l>", "<C-w>>5")

-- NeoTree keymaps

map("n", "<C-n>", ":Neotree toggle<CR>")

-- Lazy keymaps

map("n", "<A-L>", ":Lazy<CR>")

-- Buffer keymaps

map("n", "<C-K>", ":bd<CR>")

-- Bufferline keymaps

map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>")
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>")
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>")
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>")
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>")
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>")
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>")
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>")
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>")

-- Copilot keymaps

map("n", "<A-x>", ":Copilot toggle<CR>")
map("n", "<A-]>", ":Copilot next<CR>")
map("n", "<A-[>", ":Copilot prev<CR>")

-- LSP keymaps

map("n", "<A-d>", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<A-;>", ":lua vim.lsp.buf.rename()<CR>")
map("n", "K", ":lua vim.lsp.buf.hover()<CR>")

-- Telescope keymaps

map("n", "<A-F>", ":Telescope find_files<CR>")
map("n", "<A-G>", ":Telescope live_grep<CR>")
map("n", "<A-B>", ":Telescope buffers<CR>")
map("n", "<A-H>", ":Telescope help_tags<CR>")
map("n", "<A-M>", ":Telescope marks<CR>")
map("n", "<A-R>", ":Telescope registers<CR>")
map("n", "<A-S>", ":Telescope lsp_document_symbols<CR>")
map("n", "<A-T>", ":Telescope treesitter<CR>")
map("n", "<A-V>", ":Telescope vim_options<CR>")
map("n", "<A-X>", ":Telescope commands<CR>")
map("n", "<A-Z>", ":Telescope colorscheme<CR>")
map("n", "<A-~>", ":Telescope lsp_workspace_symbols<CR>")
