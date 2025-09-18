{pkgs, ...}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./fanCtrl.nix
  ];
  nixpkgs.config.allowUnfree = true;
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

  programs.fish.enable = true;
  users.users.hexolexo = {
    isNormalUser = true;
    description = "hexolexo";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  environment.systemPackages = with pkgs; [
    starship
    anki
    shadowsocks-rust
    proxychains-ng
    gnome-disk-utility
    thefuck
    polkit_gnome
    zoxide
    fzf
    wireguard-tools
    highlight
    pinentry-tty
    pass
    socat
    pkg-config
    wl-clipboard

    gsettings-desktop-schemas
    glib
    (catppuccin-gtk.override {
      accents = ["lavender"];
      variant = "mocha";
    })
    librewolf
    mindustry-wayland
    libreoffice # fucking docx
    mcstatus
    grimblast
    eww
    alacritty
    clipse
    wofi
    mpv
    ydotool
    swaybg
    swaylock-effects
    pamixer

    unstable.neovim
    brightnessctl
    yt-dlp
    micro
    marksman
    git
    go
    cargo
    libxkbcommon
    rustc
    elmPackages.elm-language-server
    lua-language-server
    nil # Nix LSP
    gopls # Go LSP
    bash-language-server
    ripgrep
    jq
    obsidian
    stylua # Lua formatter

    virt-manager
    keyd
    opentofu
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  services = {
    displayManager.ly.enable = true;
    blueman.enable = true;

    xserver = {
      enable = true;
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
  console.keyMap = "colemak";

  programs = {
    firefox.enable = true;
    steam.enable = true;
    hyprland.enable = true;
  };

  fonts.packages = [pkgs.nerd-fonts.fira-code];
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    graphics.enable = true;
  };

  services.fanControl = {
    enable = true;
    allowedUsers = ["hexolexo"];
    quietDuty = 40;
    maxDuty = 100;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  services.logind = {
    lidSwitch = "ignore"; # When on battery
    lidSwitchExternalPower = "ignore"; # When plugged in
    lidSwitchDocked = "ignore"; # When docked/external monitor
  };

  networking.networkmanager.wifi.powersave = false;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.pcscd.enable = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  system.stateVersion = "25.05";
}
