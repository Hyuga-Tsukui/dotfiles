if not vim.g.vscode then
	require("core.options")
	require("config.lazy")

	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
			end,
		},
	})
end

require("core.keymaps")

