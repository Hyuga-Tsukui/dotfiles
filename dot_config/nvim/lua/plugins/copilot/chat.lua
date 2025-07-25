return {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken', -- tiktoken is a official command to get a token that is consumed by Copilot. REF: https://github.com/gptlang/lua-tiktoken
    opts = {
        -- See Configuration section for options
    },
    cmd = 'CopilotChat',
    config = function()
        local select = require('CopilotChat.select')
        local selectCb = function(source)
            return select.visual(source) or select.buffer(source)
        end
        require('CopilotChat').setup({
            debug = false,
            proxy = nil,
            allow_insecure = false,
            model = 'gpt-4o',
            temperature = 0.1,
            prompts = {
                Explain = {
                    prompt = '/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。',
                    selection = selectCb,
                },
                Fix = {
                    prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
                    selection = selectCb,
                },
                Optimize = {
                    prompt = '/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。',
                    selection = selectCb,
                },
                Docs = {
                    prompt = '/COPILOT_DOCS 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
                    selection = selectCb,
                },
                Tests = {
                    prompt = '/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。',
                    selection = selectCb,
                },
                FixDiagnostic = {
                    prompt = '/COPILOT_FIXDIAGNOSTIC ファイル内の次のような診断上の問題を解決してください：',
                    selection = selectCb,
                },
                Commit = {
                    prompt = '/COPILOT_COMMIT この変更をコミットしてください。',
                    selection = selectCb,
                },
                CommitStaged = {
                    prompt = '/COPILOT_COMMITSTAGED ステージングされた変更をコミットしてください。',
                    selection = selectCb,
                },
            },
            window = {
                layout = 'vertical',
                width = 0.3,
                height = 0.3,
                relative = 'editor',
                border = 'single',
                row = 0,
                col = 0,
                title = 'Copilot Chat',
                footer = 'Press q to close',
                zindex = 1,
            },
            keymaps = {
                close = 'q',
                reset = '<C-l>',
                complete = '<Tab>',
            },
        })
    end,
}
