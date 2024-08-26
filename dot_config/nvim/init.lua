if not vim.g.vscode then
	-- require("plugins-setup")
	require("core.keymaps")
	require("config.lazy")
	local opt = vim.opt
	opt.tabstop = 4
	opt.expandtab = true
	opt.shiftwidth = 4
	opt.smartindent = true
	opt.relativenumber = true
	opt.cmdheight = 0
	opt.conceallevel = 2


	vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { silent = true })

	-- autocmd
	vim.api.nvim_create_autocmd("TermOpen", {
		pattern = "*",
		callback = function()
			opt.relativenumber = false
			opt.number = false
		end,
	})

	function Open_cheatsheet()
		local che = vim.fn.stdpath("config") .. "/cheatsheet.md"
		vim.cmd("split " .. che)
		vim.cmd("setlocal readonly")
		vim.cmd("resize 10")
	end

	-- keymaps.
	vim.keymap.set("n", "[b", ":bprev<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<C-j>", ":bprev<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>cs", "<cmd>lua Open_cheatsheet()<CR>", { noremap = true, silent = true })

	vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>w", { noremap = true, silent = true })

	local undodir = vim.fn.stdpath("config") .. "/undo"
	if vim.fn.isdirectory(undodir) == 0 then
		vim.fn.mkdir(undodir, "p")
	end
	vim.opt.undodir = undodir
	vim.opt.undofile = true

	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
			end,
		},
	})
end

local keymap = vim.keymap
keymap.set("i", "jj", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<S-k>", "10<UP>")
keymap.set("n", "<S-j>", "10<DOWN>")
keymap.set("n", "<S-h>", "10<LEFT>")
keymap.set("n", "<S-l>", "10<RIGHT>")

keymap.set("v", "<S-k>", "10<UP>")
keymap.set("v", "<S-j>", "10<DOWN>")
keymap.set("v", "<S-h>", "10<LEFT>")
keymap.set("v", "<S-l>", "10<RIGHT>")

vim.opt.clipboard:append("unnamedplus")
