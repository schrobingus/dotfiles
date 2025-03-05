{ ... }:

{
  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSWindowShouldDragOnGesture = true;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      orientation = "right";
      showhidden = true;
      show-recents = false;
    };
    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      "com.apple.finder".FXPreferredViewStyle = "clmv";
    };
  };
}
