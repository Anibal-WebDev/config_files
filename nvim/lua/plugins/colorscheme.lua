return {
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
}
