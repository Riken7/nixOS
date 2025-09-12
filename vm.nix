{pkgs, ...}:{
  environment.systemPackages = with pkgs; [
  qemu
];

virtualisation.libvirtd.enable = true;
users.extraGroups.libvirtd.members = [ "rik" ];
}
