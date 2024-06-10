return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
		defaults = {
			layout_strategy = "vertical",
			layout_config = { height = 0.95 },
		},
	},
}
