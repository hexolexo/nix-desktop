{pkgs, ...}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
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

  environment.systemPackages = with pkgs; [
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
  ];
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
  ];
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
}
