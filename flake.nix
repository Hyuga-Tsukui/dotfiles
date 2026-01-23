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

      ghost = pkgs.stdenvNoCC.mkDerivation rec {
        pname = "ghost";
        version = "0.3.0";

        src = pkgs.fetchzip {
          url = "https://github.com/skanehira/ghost/releases/download/v${version}/ghost_aarch64-apple-darwin.tar.gz";
          sha256 = "sha256-JJ2YcDKaXpynyUz8TaNj3q+DbRwhcl0cY3QBTAwUM4s=";
        };

        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          install -m 0755 ghost $out/bin/ghost
          runHook postInstall
        '';
      };
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
          pkgs.just
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
          ghost
        ];
      };
    };
}
