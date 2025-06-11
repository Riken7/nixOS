{pkgs , ...}:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "screenshootin" ''
      grim -g "$(slurp)" - | swappy -f -
    '')
  ];
}
