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
                Rename = {
                    prompt = '/COPILOT_RENAME CONTEXTに基づき，選択したコードの変数名を適切な名前に変更してください。',
                    selection = selectCb,
                },
            },
            window = {
                layout = 'vertical',
                width = 120, -- Fixed width in columns
                height = 40, -- Fixed height in rows
                border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
                title = '🤖 AI Assistant',
                zindex = 100, -- Ensure window stays on top
            },

            headers = {
                user = '👤 You: ',
                assistant = '🤖 Copilot: ',
                tool = '🔧 Tool: ',
            },
            separator = '━━',
            show_folds = false, -- Disable folding for cleaner look           -- },
            keymaps = {
                close = 'q',
                reset = '<C-l>',
                complete = '<Tab>',
            },
        })
    end,
    keys = {
        { '<leader>zn', ':CopilotChatRename<CR>', mode = 'v', desc = 'Rename Variable' },
        { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = 'Open Copilot Chat' },
        { '<leader>zc', ':CopilotChat<CR>', mode = 'v', desc = 'Open Copilot Chat' },
        { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
        { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
        { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issue' },
        { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
        { '<leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
        { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
        { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit' },
        { '<leader>zs', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Generate Commit for Selection' },
    },
}
