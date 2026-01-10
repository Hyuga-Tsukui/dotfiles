{
  description = "Minimal package definition for aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, }: {
    packages.aarch64-darwin.my-packages = nixpkgs.legacyPackages.aarch64-darwin.buildEnv {
      name = "my-packages-list";
      paths = [
        nixpkgs.legacyPackages.aarch64-darwin.adr-tools
        nixpkgs.legacyPackages.aarch64-darwin.bat
        nixpkgs.legacyPackages.aarch64-darwin.codex
        nixpkgs.legacyPackages.aarch64-darwin.curl
        nixpkgs.legacyPackages.aarch64-darwin.delta
        nixpkgs.legacyPackages.aarch64-darwin.deno
        nixpkgs.legacyPackages.aarch64-darwin.eza
        nixpkgs.legacyPackages.aarch64-darwin.fd
        nixpkgs.legacyPackages.aarch64-darwin.fzf
        nixpkgs.legacyPackages.aarch64-darwin.gh
        nixpkgs.legacyPackages.aarch64-darwin.ghq
        nixpkgs.legacyPackages.aarch64-darwin.git
        nixpkgs.legacyPackages.aarch64-darwin.gitmux
        nixpkgs.legacyPackages.aarch64-darwin.jq
        nixpkgs.legacyPackages.aarch64-darwin.mise
        nixpkgs.legacyPackages.aarch64-darwin.uv
        nixpkgs.legacyPackages.aarch64-darwin.ripgrep
        nixpkgs.legacyPackages.aarch64-darwin.tmux
        nixpkgs.legacyPackages.aarch64-darwin.tlrc
        nixpkgs.legacyPackages.aarch64-darwin.typos
        neovim-nightly-overlay.packages.aarch64-darwin.neovim
        nixpkgs.legacyPackages.aarch64-darwin.volta
        nixpkgs.legacyPackages.aarch64-darwin.zoxide
        nixpkgs.legacyPackages.aarch64-darwin.zsh-completions
        nixpkgs.legacyPackages.aarch64-darwin.zsh-autosuggestions
      ];
    };
  };
}
