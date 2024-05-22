vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.mouse = ""

vim.g.mapleader = ""
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},

		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
				terminal_colors = true,
					styles = { comments = { italic = true },
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
		"stevearc/oil.nvim", 
		config = function()
			require("oil").setup({
				theme = "tokyonight",
				italic_comments = true,
				italic_keywords = true,
				italic_functions = true,
				italic_variables = true,
				transparent_background = true,
				sidebars = { "qf", "vista_kind", "terminal", "packer" },
				floating_windows = { "qf", "terminal", "packer" },
			})
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
				  next = "<M-]>",
				  prev = "<M-[>",
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
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = {
					theme = 'material',
				},
			})
		end,
	},

	{
		'neovim/nvim-lspconfig',
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
			require'cmp'.setup {
			  sources = {
				{ name = 'nvim_lsp' }
			  }
			}

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require('lspconfig').clangd.setup {
				capabilities = capabilities,

			}

			require'lspconfig'.pyright.setup{
				capabilities = capabilities,
			}

			require'lspconfig'.lua_ls.setup{
				capabilities = capabilities,
			}

			require('lspconfig').tsserver.setup {
				capabilities = capabilities,
			}
		end,
	},
})

vim.cmd[[colorscheme tokyonight]]

local function map(m, k, v)
		vim.keymap.set(m, k, v)
end

-- Misc keymaps

map("n", "<A-n>", ":tabnew<CR>")
map("n", "<A-q>", ":q<CR>")
map("n", "<A-w>", ":w<CR>")
map("n", "<A-s>", ":wq<CR>")

-- Lazy keymaps

map("n", "<A-l>", ":Lazy<CR>")

-- Buffer keymaps

map("n", "<A-b>", ":vs :buf<CR>")

-- Oil keymaps

map("n", "<A-c>", ":Oil<CR>")

-- Copilot keymaps

map("n", "<A-x>", ":Copilot<CR>")
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
