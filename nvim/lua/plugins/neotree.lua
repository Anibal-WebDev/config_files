return {
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
}
