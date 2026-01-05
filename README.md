## 設定ガイド

このdotfilesは以下のツールを使って管理している。

- [chezmoi](https://www.chezmoi.io/)
  - dotfilesの管理。
- [nix](https://github.com/NixOS/nix)
  - GUI以外のCommandLineツールなどの管理。
- [homebrew](https://brew.sh/)
  - GUIツールの管理。（chezmoiのrunタスクで初期化）

## 初期化手順

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Hyuga-Tsukui
```
