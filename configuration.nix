{pkgs, ...}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  imports = [
    ./hardware-configuration.nix
    ./modules/fanCtrl.nix # Moved to hardware
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

    gsettings-desktop-schemas
    glib
    #catppuccin-gtk
    (catppuccin-gtk.override {
      accents = ["lavender"]; # Add the accents you want
      variant = "mocha"; # Default variant
      # You can also specify multiple variants:
      # variants = [ "mocha" "frappe" ];
    })
    unstable.hyprland
    librewolf
    mindustry-wayland
    nyxt
    libreoffice # fucking docx
    mcstatus
    grimblast
    obsidian
    eww
    unstable.alacritty
    clipse
    wofi
    mpv
    ydotool
    swaybg
    swaylock-effects
    pamixer
    bluez

    bluez-tools

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

  services = {
    displayManager.ly.enable = true;
    blueman.enable = true;

    xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "colemak";
      };
    };
    printing.enable = true;
    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;
  console = {
    keyMap = "colemak";
  };

  programs = {
    firefox.enable = true;
    hyprland.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
  ];
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

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
