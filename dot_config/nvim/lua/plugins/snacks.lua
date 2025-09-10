-- art.lua を読み込む（この時点で I2A* の set_hl も実行される）
local art = require('assets.rei-art')

-- 0-based, 半開区間 [s, e) を Lua の 1-based 文字列へ変換してセグメント化
local function to_segments(line, ranges)
    local segs = {}
    if not ranges then
        return { { line } }
    end
    for _, r in ipairs(ranges) do
        local group, s, e = r[1], r[2], r[3]
        -- 0-based [s,e) → 1-based [s+1, e] （Lua の :sub は終端を含む）
        local seg = line:sub(s + 1, e)
        table.insert(segs, { seg, hl = group })
    end
    return segs
end

local function make_art_text(a)
    local t = {}
    for i, line in ipairs(a.val or {}) do
        -- 各行を「セグメント配列（1行）」に変換
        t[i] = to_segments(line, a.opts and a.opts.hl and a.opts.hl[i])
    end
    return t
end

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            sources = {
                files = {
                    exclude = {
                        '/undo/',
                    },
                },
                diagnostics = {
                    exclude = {
                        '/undo/',
                    },
                },
            },
        },
        -- dashboard = {
        --     enabled = true,
        --     pane_gap = 4,
        --     preset = {
        --         header = table.concat(header_val, '\n'),
        --     },
        --     sections = {
        --         {
        --             section = 'header',
        --         },
        --         {
        --             pane = 2,
        --             padding = { 0, 8 },
        --             { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        --             { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        --             { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        --             { section = 'startup' },
        --         },
        --     },
        -- },
        -- dashboard = {
        --     enabled = true,
        --     pane_gap = 4,
        --
        --     sections = {
        --         {
        --             -- text = (function()
        --             --     local lines = {}
        --             --     for i, line in ipairs(art.val) do
        --             --         lines[i] = {
        --             --             text = line,
        --             --             hl = art.opts.hl[i],
        --             --             align = 'center',
        --             --         }
        --             --     end
        --             --     return lines
        --             -- end)(),
        --             text = make_art_text(art),
        --         },
        --         {
        --             pane = 2,
        --             padding = { 0, 8 },
        --             { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        --             { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        --             { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        --             { section = 'startup' },
        --         },
        --     },
        -- },
        notifier = {},
    },
    keys = {
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = 'Git Log Line',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git Branches',
        },
        {
            '<leader>gs',
            function()
                Snacks.picker.git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>gd',
            function()
                Snacks.picker.git_diff()
            end,
        },
        {
            '<leader>/',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>fs',
            function()
                Snacks.picker.files()
            end,
            desc = 'Search File',
        },
        {
            '<leader>bs',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers Picker',
        },
        {
            '<leader>sc',
            function()
                Snacks.picker.command_history({
                    on_select = function(item)
                        print('Executing command: ' .. item.value)
                        vim.api.nvim_feedkeys(';' .. item.value .. '\n', 'n', false)
                    end,
                })
            end,
            desc = 'Commands Picker',
        },
        {
            '<leader>ds',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Diagnostics',
        },
        {
            '<leader>nn',
            function()
                Snacks.picker.notifications()
            end,
            desc = 'Notifications',
        },
    },
}
