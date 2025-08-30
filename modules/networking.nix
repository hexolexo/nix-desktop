{
  config,
  pkgs,
  ...
}: {
  services.tailscale.enable = true;
  networking.hosts = {
    "REDACTED_HOME_IP" = ["home"];
    "192.168.1.153" = ["server"];
    #"192.168.0.10" = ["backup"];
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
}
