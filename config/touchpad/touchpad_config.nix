{
  services.xserver.inputClassSections = [ ''
    Identifier "Disable ELAN mouse"
    MatchProduct "ELAN0718:01 04F3:30FD Mouse"
    Option "Ignore" "on"
  ''
  ''
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Driver "libinput"
    Option "DisableWhileTyping" "true"
    Option "AccelSpeed" "0.4"
    Option "Tapping" "true"
    Option "NaturalScrolling" "false"
    Option "MiddleEmulation" "false"
    Option "TappingButtonMap" "lrm"
  ''
  ];

}
