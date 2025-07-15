---@class utils.lsp
local M = {}

---Auto-detect and return available LSP servers from after/lsp/ directory
---@return string[] lsp_servers List of available LSP server names
function M.get_available_lsp_servers()
    ---@type string[]
    local lsp_servers = {}
    ---@type string
    local lsp_dir = vim.fn.stdpath('config') .. '/after/lsp'

    if vim.fn.isdirectory(lsp_dir) == 1 then
        ---@type string[]
        local files = vim.fn.readdir(lsp_dir)
        for _, file in ipairs(files) do
            if file:match('%.lua$') then
                ---@type string
                local server_name = file:gsub('%.lua$', '')
                table.insert(lsp_servers, server_name)
            end
        end
    end

    return lsp_servers
end

return M
