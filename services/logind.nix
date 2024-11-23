{
  services.logind = {
    powerKey = "lock";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "suspend-then-hibernate";
  };
}
