return {
    cmd = { "npx", "biome", "lsp-proxy" },
    on_new_config = function(new_config, new_root_dir)
        -- 環境変数で biome.json を指定
        new_config.cmd_env = {
            BIOME_CONFIG_PATH = new_root_dir .. "/biome.json",
        }
    end,
    root_dir = function(fname)
        local util = require("lspconfig.util")
        -- biome.json を探すロジック
        return util.root_pattern("biome.json")(fname) -- biome.json を基準にルートディレクトリを設定
            or util.find_git_ancestor(fname)    -- .git を基準にルートディレクトリを設定
            or util.path.dirname(fname)         -- デフォルトは現在のファイルのディレクトリ
    end,
    settings = {},
}
