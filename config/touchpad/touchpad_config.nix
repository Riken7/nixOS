{
  #  services.xserver.inputClassSections = [ ''
  #    Identifier "Disable ELAN mouse"
  #    MatchProduct "ELAN0718:01 04F3:30FD Mouse"
  #    Option "Ignore" "on"
  #  ''
  #  ''
  #    Identifier "libinput touchpad catchall"
  #    MatchIsTouchpad "on"
  #    MatchDevicePath "/dev/input/event*"
  #    Driver "libinput"
  #    Option "DisableWhileTyping" "false"
  #    Option "AccelSpeed" "0.4"
  #    Option "Tapping" "false"
  #    Option "NaturalScrolling" "false"
  #    Option "MiddleEmulation" "false"
  #    Option "TappingButtonMap" "lrm"
  #  ''
  #  ];
  #
  boot.kernelModules = [ "i2c_hid" "i2c_hid_acpi"];
  boot.blacklistedKernelModules = ["psmouse"];

  boot.extraModprobeConfig = ''
    softdep i2c_hid_acpi pre: pinctrl_amd
    softdep i2c_hid pre: pinctrl_amd
  '';
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="i2c", ATTR{power/control}="on"
  '';

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = false;
      disableWhileTyping = true;
      naturalScrolling = true;
      clickMethod = "none";
      scrollMethod = "twofinger";
      middleEmulation = false;
    };
  };
}
