{...}: let
  secrets = import ./secrets.nix;
in {
  networking.hosts = {
    "${secrets.HomeIP}" = ["home"];
    "${secrets.ServerIP}" = ["server"];
  };
  environment.etc."proxychains.conf".text = ''
    # Proxy DNS requests
    proxy_dns

    # Timeouts in milliseconds
    tcp_read_time_out 15000
    tcp_connect_time_out 8000

    # Proxy chain type
    strict_chain

    [ProxyList]
    socks5 127.0.0.1 1080
  '';
  #networking.firewall.allowedUDPPorts = [51820 6567];
  #networking.firewall.allowedTCPPorts = [6567];
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.0.0.2/24"];

      privateKeyFile = "/etc/wireguard/privkey";

      peers = [
        {
          publicKey = "6Kyt3gNgDW/9g14BYSMyaNgVPHA7AR7fthLoUOMgRQE=";
          endpoint = "${secrets.HomeIP}:51820";

          allowedIPs = ["10.0.0.0/24"];
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
