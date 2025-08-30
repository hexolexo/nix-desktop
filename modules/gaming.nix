{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
  programs.steam.enable = true;
}
