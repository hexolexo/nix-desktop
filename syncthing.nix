{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    user = "hexolexo";
    dataDir = "/home/hexolexo/.syncthing";
    configDir = "/home/hexolexo/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "phone" = {
          id = "DEVICE-ID-FROM-PHONE-GOES-HERE";
          addresses = ["tcp://10.0.0.5:22000"]; # your phone's WireGuard IP
        };
      };

      folders = {
        "music" = {
          path = "/home/hexolexo/Music";
          devices = ["phone"];
          type = "sendonly";
        };
      };

      options = {
        globalAnnounceEnabled = false;
        relaysEnabled = false;
        localAnnounceEnabled = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    strawberry
  ];
}
