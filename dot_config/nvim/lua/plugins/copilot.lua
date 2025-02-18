return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        build = ":Copilot auth",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                    gitcommit = true,
                },
            })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },              -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                   -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
        --
        config = function()
            local select = require("CopilotChat.select")
            require("CopilotChat").setup({
                debug = false,
                proxy = nil,
                allow_insecure = false,
                model = "claude-3.5-sonnet",
                temperature = 0.1,
                prompts = {
                    Explain = {
                        prompt = "/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。",
                        selection = select.selection or function()
                            return {}
                        end,
                    },
                    Fix = {
                        prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
                        selection = select.selection or function()
                            return {}
                        end,
                    },
                    Optimize = {
                        prompt = "/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
                        selection = select.selection or function()
                            return {}
                        end,
                    },
                    Docs = {
                        prompt =
                        "/COPILOT_DOCS 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
                        selection = select.selection or function()
                            return {}
                        end,
                    },
                    Tests = {
                        prompt = "/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。",
                        selection = select.selection or function()
                            return {}
                        end,
                    },
                    FixDiagnostic = {
                        prompt = "/COPILOT_FIXDIAGNOSTIC ファイル内の次のような診断上の問題を解決してください：",
                        selection = select.diagnostics or select.selection or function()
                            return {}
                        end,
                    },
                    Commit = {
                        prompt = "/COPILOT_COMMIT この変更をコミットしてください。",
                        selection = select.gitdiff or select.selection or function()
                            return {}
                        end,
                    },
                    CommitStaged = {
                        prompt = "/COPILOT_COMMITSTAGED ステージングされた変更をコミットしてください。",
                        selection = select.selection or function()
                            return {}
                        end,
                    },
                },
                window = {
                    layout = "vertical",
                    width = 0.3,
                    height = 0.3,
                    relative = "editor",
                    border = "single",
                    row = 0,
                    col = 0,
                    title = "Copilot Chat",
                    footer = "Press q to close",
                    zindex = 1,
                },
                keymaps = {
                    close = "q",
                    reset = "<C-l>",
                    complete = "<Tab>",
                },
            })
        end,
    },
}
