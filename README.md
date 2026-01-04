## 設定ガイド

このdotfilesは以下のツールを使って管理している。

- [chezmoi](https://www.chezmoi.io/)
  - dotfilesの管理。
- [nix](https://github.com/NixOS/nix)
  - GUI以外のCommandLineツールなどの管理。
- [homebrew](https://brew.sh/)
  - GUIツールの管理。（chezmoiのrunタスクで初期化）

## 初期化手順

1. chezmoiのインストールとdotfilesの展開

```sh
cd
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Hyuga-Tsukui
```

2. nixのインストールとプロファイルの有効化

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

```sh
nix profile install .#my-packages
```
