return {
    cmd = { 'npx', 'biome', 'lsp-proxy' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { 'biome.json', '.git' }) or vim.fn.getcwd()
        print('Biomae root dir: ' .. root)
        on_dir(root)
    end,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd_env = {
            BIOME_CONFIG_PATH = new_root_dir .. '/biome.json',
        }
    end,
    settings = {},
}
