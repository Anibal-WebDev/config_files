return {
	{'AndreM222/copilot-lualine'},
	{'nvim-tree/nvim-web-devicons'},
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
					always_divide_middle = false,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
					lualine_c = { 'selectioncount' },
					lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location', 'datetime' },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {
					lualine_a = { 'buffers' },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'tabs' }
				},
				winbar = {},
				inactive_winbar = {},
				extensions = { 'quickfix' },
			}
		end
	},
}
