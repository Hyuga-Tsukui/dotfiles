return function()
    local lspconfig = require("lspconfig")

    ---@param names string[]
    ---@return string[]
    local function get_plugin_paths(names)
        local plugins = require("lazy.core.config").plugins
        local paths = {}
        for _, name in ipairs(names) do
            if plugins[name] then
                table.insert(paths, plugins[name].dir .. "/lua")
            else
                vim.notify("Invalid plugin name: " .. name, vim.log.levels.WARN)
            end
        end
        return paths
    end

    ---@param plugins string[]
    ---@return string[]
    local function library(plugins)
        local paths = get_plugin_paths(plugins)
        table.insert(paths, vim.fn.stdpath("config") .. "/lua")
        table.insert(paths, vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua")
        table.insert(paths, vim.env.VIMRUNTIME .. "/lua")
        table.insert(paths, "${3rd}/luv/library")
        table.insert(paths, "${3rd}/busted/library")
        table.insert(paths, "${3rd}/luassert/library")
        return paths
    end

    local lua_ls_opts = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    maxPreload = 10000,
                    preloadFileSize = 5000,
                    library = library({ "lazy.nvim" }),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }

    lspconfig.lua_ls.setup(lua_ls_opts)
end
