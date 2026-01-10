{
  description = "Minimal package definition for aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.my-packages = pkgs.buildEnv {
        name = "my-packages-list";
        paths = [
          pkgs.adr-tools
          pkgs.bat
          pkgs.codex
          pkgs.curl
          pkgs.delta
          pkgs.deno
          pkgs.eza
          pkgs.fd
          pkgs.fzf
          pkgs.gh
          pkgs.ghq
          pkgs.git
          pkgs.gitmux
          pkgs.jq
          pkgs.mise
          pkgs.uv
          pkgs.ripgrep
          pkgs.tmux
          pkgs.tlrc
          pkgs.typos
          neovim-nightly-overlay.packages.aarch64-darwin.neovim
          pkgs.volta
          pkgs.zoxide
          pkgs.zsh-completions
          pkgs.zsh-autosuggestions
        ];
      };
    };
}
