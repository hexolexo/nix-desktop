{
  config,
  pkgs,
  ...
}: {
  # Enable libvirtd service
  #virtualisation.libvirtd = {
  #enable = true;
  #qemu = {
  ##package = pkgs.qemu_kvm;
  #runAsRoot = true;
  #swtpm.enable = true;
  #ovmf.enable = true;
  #ovmf.packages = [pkgs.OVMFFull.fd];
  #};
  #};

  # Add your user to the libvirtd group
  #users.users.hexolexo = {
  #extraGroups = ["libvirtd"];
  #};

  # Optional: Install virt-manager for GUI management
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];
}
