if not vim.g.vscode then
	require("core.options")
	require("core.keymaps")
	require("config.lazy")

	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
			end,
		},
	})
end

local keymap = vim.keymap

keymap.set("n", "<S-k>", "10<UP>")
keymap.set("n", "<S-j>", "10<DOWN>")
keymap.set("n", "<S-h>", "10<LEFT>")
keymap.set("n", "<S-l>", "10<RIGHT>")

keymap.set("v", "<S-k>", "10<UP>")
keymap.set("v", "<S-j>", "10<DOWN>")
keymap.set("v", "<S-h>", "10<LEFT>")
keymap.set("v", "<S-l>", "10<RIGHT>")
