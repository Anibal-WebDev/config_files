return {
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
}
