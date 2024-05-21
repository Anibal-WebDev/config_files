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
				style = "night",
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
    	'nvim-telescope/telescope.nvim', tag = '0.1.6',
      	dependencies = { 'nvim-lua/plenary.nvim' }
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
		end,
	},
--[[
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	}
]]
})

vim.cmd[[colorscheme tokyonight]]

-- Custom key bindings

vim.keymap.set("n", "<A-l>", ":Lazy<CR>")
vim.keymap.set("n", "<A-n>", ":tabnew<CR>")
vim.keymap.set("n", "<A-q>", ":q<CR>")
vim.keymap.set("n", "<A-w>", ":w<CR>")
vim.keymap.set("n", "<A-s>", ":wq<CR>")
vim.keymap.set("n", "<A-F>", ":Telescope find_files<CR>")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

