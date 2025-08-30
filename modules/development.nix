{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim
    micro
    marksman
    git
    clang
    go
    cargo
    rustc
    gcc
    elmPackages.elm-language-server
    lua-language-server
    nil # Nix LSP
    gopls # Go LSP
    bash-language-server
    pkg-config
    ripgrep
    jq
    stylua # Lua formatter
    fzf
    wl-clipboard
  ];
}
