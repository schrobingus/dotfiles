{ ... }:

{
  homebrew = {
    enable = true;

    taps = [];
    brews = [
      "xcodes"
    ];
    casks = [
      "librewolf"
      "raycast"
      "wezterm"

      "steam"
      "ultimaker-cura"
    ];
  };
}
