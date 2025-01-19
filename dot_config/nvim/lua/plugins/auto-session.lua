return {
    "rmagatti/auto-session",
    lazy = false,

    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        cwd_change_handling = true,

        pre_cwd_changed_cmds = {
            "NvimTreeClose",
        },
    },
    config = function(_, opts)
        local fzf_lua = require("fzf-lua")

        local auto_session = require("auto-session")
        local lib = require("auto-session.lib")
        auto_session.setup(opts)

        local function fzf_session_search()
            local sessions = lib.get_session_list(auto_session.get_root_dir())

            if not sessions or #sessions == 0 then
                vim.notify("No sessions found", vim.log.levels.INFO)
                return
            end

            local display_entries = {}
            local path_map = {}

            for _, session in ipairs(sessions) do
                local display = session.display_name
                table.insert(display_entries, display)
                path_map[display] = session.path -- 削除するために追加.
            end

            fzf_lua.fzf_exec(display_entries, {
                prompt = "sesstions>",
                fzf_opts = {
                    ["--header"] = "(ENTER:restore | CTRL-X:delete)",
                },
                winopts = {
                    height = 0.5,
                    width = 0.7,
                    border = "rounded",
                },
                actions = {
                    ["default"] = function(selected)
                        auto_session.autosave_and_restore(selected[1])
                    end,
                    ["ctrl-x"] = function(selected)
                        auto_session.DeleteSessionFile(path_map[selected[1]], selected[1])
                        vim.notify("Session deleted: " .. selected[1], vim.log.levels.INFO)
                    end,
                },
            })
        end
        vim.keymap.set("n", "<C-p>s", fzf_session_search, { noremap = true })
    end,
}
