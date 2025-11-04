return {
    'https://github.com/obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false,
        picker = {
            name = 'snacks.pick',
        },
        sort_by = 'modified',
        ui = {
            external_link_icon = {},
        },
        attachments = {
            img_folder = '003_ext',
        },
        open_notes_in = 'current',
        daily_notes = {
            folder = '002_daily',
            date_format = '%Y-%m-%d',
        },
        workspaces = {
            {
                name = 'my_vault',
                path = vim.fn.expand('~/ws/obsidian-work'),
                overrides = {},
            },
        },
        --@param spec{ id: string, dir: obsidian.Path, title: string|? }
        --@return string|obsidean.Path The full path to the new note
        note_path_func = function(spec)
            local title = spec.title or spec.id
            title = title:gsub('[%s/\\:%?%*"<>|]+', '_'):gsub('^_+', '')
            local path = spec.dir / title
            return path:with_suffix('.md')
        end,
    },
    cmd = {
        'Obsidian',
    },
}
