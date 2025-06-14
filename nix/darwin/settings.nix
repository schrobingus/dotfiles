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
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      "com.apple.finder".FXPreferredViewStyle = "clmv";
      "com.knollsoft.Rectangle" = {
        gapSize = 16;
        screenEdgeGapTop = 24;
        screenEdgeGapBottom = 24;
      };

      # TODO: make a boolean that calls to enable / disable stage manager
      
      # With Stage Manager
      # "com.apple.WindowManager".GloballyEnabled = true;
      # "com.knollsoft.Rectangle" = {
      #   screenEdgeGapRight = 128;
      #   screenEdgeGapLeft = 0; # Side gap applied by default in SM.
      # };

      # Without Stage Manager
      "com.apple.WindowManager".GloballyEnabled = false;
      "com.knollsoft.Rectangle" = {
        screenEdgeGapRight = 24;
        screenEdgeGapLeft = 24;
      };
    };
  };
}
