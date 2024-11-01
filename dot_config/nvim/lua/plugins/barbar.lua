return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufEnter" },
	config = function()
		require("barbar").setup({
			sidebar_filetypes = {
				-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
				NvimTree = true,
				-- Or, specify the text used for the offset:
				undotree = {
					text = "undotree",
					align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
				},
				-- Or, specify the event which the sidebar executes when leaving:
				["neo-tree"] = { event = "BufWipeout" },
				-- Or, specify all three
				Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
			},
			animation = false,
		})
		vim.keymap.set("n", "<TAB>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<S-TAB>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>p", "<Cmd>BufferPick<CR>", { noremap = true, silent = true })
		-- vim.keymap.set("n", "<leader>w", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ac", "<Cmd>BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })

		local max_buf = 6
		local function close_buffer()
			local buffer_count = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
			if buffer_count >= max_buf then
				vim.cmd("BufferCloseAllButCurrent")
			end
		end
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = close_buffer,
		})
	end,
}
