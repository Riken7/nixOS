{ ...}:
{hardware.nvidia = {
    modesetting.enable = true; 
    powerManagement.enable = false; 
    powerManagement.finegrained = true; 
    open = false; 
    nvidiaSettings = true; 
    prime = {
      offload = {
        enable = true; 
        enableOffloadCmd = true; 
      };
      nvidiaBusId = "PCI:1:0:0"; 
      amdgpuBusId = "PCI:5:0:0"; 
    };
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Use NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
}
