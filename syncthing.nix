{...}: {
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
          id = "RXVKLMQ-KPMFZX2-ZRUFDOZ-6RUTNEG-GBQ4VVX-64I5JC6-BYWJJ74-HZZPVAO";
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
}
