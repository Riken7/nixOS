{config, pkgs, ... }:

{
  systemd.services.sshfsMount = {
    description = "SSHFS Mount for File Browser";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStartPre = "echo 'SSH_ADDRESS: ${config.sops.secrets.address.path}' > /tmp/sshfs-debug.log";
      ExecStart = "${pkgs.sshfs}/bin/sshfs ${config.sops.secrets.address.path}:/home/hs/srv/filebrowser/riken /home/rik/home-server";
      ExecStop = "${pkgs.umount}/bin/umount /home/rik/home-server";
      Restart = "always";
    };
  };
}
