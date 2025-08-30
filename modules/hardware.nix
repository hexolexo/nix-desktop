{
  config,
  pkgs,
  ...
}: {
  imports = [./fanCtrl.nix];
  services.fanControl = {
    enable = true;
    allowedUsers = ["hexolexo"];
    quietDuty = 40;
    maxDuty = 100;
  };
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
