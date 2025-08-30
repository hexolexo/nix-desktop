{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  imports = [
    ./hardware-configuration.nix
    #./modules/fanCtrl.nix # Moved to hardware
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/security.nix
    ./modules/development.nix
    ./modules/gaming.nix
    ./modules/networking.nix
    ./modules/virtualisation.nix # Incomplete
  ];
  security.polkit.enable = true;
  services.udisks2.enable = true;
  services.dbus.enable = true;
  programs.dconf.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hexolexo";

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.hexolexo = {
    isNormalUser = true;
    description = "hexolexo";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    #packages = with pkgs; [
    #];
  };
  environment.systemPackages = with pkgs; [
    fish
    starship
    anki
    shadowsocks-rust
    proxychains-ng
    gnome-disk-utility
    thefuck
    polkit_gnome # Polkit authentication agent
    zoxide
    fzf
    highlight
    pinentry-tty
    pass
    socat
    gcc
    pkg-config
    jq
    wl-clipboard
    fzf
    highlight
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  services.fanControl = {
    enable = true;
    allowedUsers = ["hexolexo"];
    quietDuty = 40;
    maxDuty = 100;
  };
  networking.firewall.allowedUDPPorts = [51820 6567];
  networking.firewall.allowedTCPPorts = [6567];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  system.stateVersion = "25.05";
}
