local cmd = {
	"ObsidianNew",
	"ObsidianSearch",
}

local rules = {
	{ pattern = "[%s /\\?*]", replace = "-" },
}

-- Replace all characters in a string that match a pattern.
-- @param s string: The string to replace characters in.
-- @return string: The string with characters replaced.
local replace = function(s)
	for _, rule in ipairs(rules) do
		s = s:gsub(rule.pattern, rule.replace)
	end
	return s
end

local opts = {
	workspaces = {
		{
			name = "personal",
			path = vim.fn.expand("~/obsidian"),
		},
	},
	notes_subdir = "inbox",
	-- disable_frontmatter = true,
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = replace(title)
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,

	note_path_func = function(spec)
		local file_name = ""
		if spec.title ~= nil then
			file_name = replace(spec.title)
		else
			file_name = spec.id
		end
		return (spec.dir / file_name):with_suffix(".md")
	end,

	picker = {
		name = "fzf-lua",
	},
}

return {
	"epwalsh/obsidian.nvim",
	cmd = cmd,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
		"hrsh7th/nvim-cmp",
	},
	opts = opts,
}
