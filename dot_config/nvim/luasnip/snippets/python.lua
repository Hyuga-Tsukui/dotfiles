-- python.lua – LuaSnip snippets for Python 3
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep -- 既存ノードの再利用

return {
    ---------------------------------------------------------------------------
    -- 1. def : 型ヒント + Docstring 付き関数
    ---------------------------------------------------------------------------
    s(
        "def",
        fmt(
            [[
def {}({}){}:
    """{}"""
    {}
]],
            {
                i(1, "func_name"), -- 関数名
                i(2), -- 引数
                -- ▼ choice_node を改良
                c(3, {
                    ls.sn(nil, { -- ← ここが “小さなスニペット” になる
                        t(" -> "),
                        i(1, "ReturnType"), -- ← ← ← 戻り値型を入力する所
                    }),
                    t(""), -- 戻り値を書かない選択肢
                }),
                i(4, "Summary."), -- Docstring
                i(0, "pass"), -- 本体
            }
        )
    ),

    ---------------------------------------------------------------------------
    -- 2. dc : dataclass スケルトン
    ---------------------------------------------------------------------------
    s(
        "dc",
        fmt(
            [[
@dataclass
class {}:
    {}: {}
]],
            {
                i(1, "MyData"), -- クラス名
                i(2, "field"), -- フィールド名
                i(3, "str"), -- 型
            }
        )
    ),

    ---------------------------------------------------------------------------
    -- 3. main : スクリプトのエントリポイント
    ---------------------------------------------------------------------------
    s(
        "main",
        t({
            'if __name__ == "__main__":',
            "\tmain()",
        })
    ),

    ---------------------------------------------------------------------------
    -- 4. log : 標準的な logging 設定
    ---------------------------------------------------------------------------
    s(
        "log",
        t({
            "import logging",
            "",
            "logging.basicConfig(",
            "\tlevel=logging.INFO,",
            '\tformat="%(asctime)s [%(levelname)s] %(message)s",',
            ")",
            "",
            "logger = logging.getLogger(__name__)",
        })
    ),

    ---------------------------------------------------------------------------
    -- 5. tst : Arrange / Act / Assert 付き pytest テスト
    ---------------------------------------------------------------------------
    s(
        "tst",
        fmt(
            [[
def test_{}():
    # Arrange
    {}
    # Act
    {}
    # Assert
    assert {}
]],
            {
                i(1, "feature"), -- テスト対象名
                i(2, "# setup"), -- Arrange
                i(3, "# exercise"), -- Act
                i(4, "expected"), -- Assert
            }
        )
    ),

    ---------------------------------------------------------------------------
    -- 6. fdbg : f-string デバッグ出力
    ---------------------------------------------------------------------------
    s("fdbg", {
        t('print(f"'),
        i(1, "var"),
        t("!r} = {"),
        rep(1),
        t('}")'),
    }),

    ---------------------------------------------------------------------------
    -- 7. prop : getter / setter 付き property
    ---------------------------------------------------------------------------
    s(
        "prop",
        fmt(
            [[
@property
def {}(self) -> {}:
    return self._{}

@{}.setter
def {}(self, value: {}) -> None:
    self._{} = value
]],
            {
                i(1, "name"), -- プロパティ名
                i(2, "str"), -- 型ヒント
                rep(1),
                rep(1),
                rep(1),
                i(3, "str"), -- setter の型
                rep(1),
            }
        )
    ),
}
