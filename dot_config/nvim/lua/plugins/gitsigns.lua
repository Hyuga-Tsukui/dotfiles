return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk)
				map("n", "<leader>hu", gitsigns.undo_stage_hunk)
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hu", function()
					gitsigns.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#4CAF50", bg = "#e0e2ea" })
				vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#FF9800", bg = "#e0e2ea" })
				vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#F44336", bg = "#e0e2ea" })
			end,
			numhl = true,
			signcolumn = false,
		})
	end,
}
