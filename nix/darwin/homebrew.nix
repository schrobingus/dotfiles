{ ... }:

{
  homebrew = {
    enable = true;

    taps = [];
    brews = [
      "cocoapods"
      "xcodes"

      "podman" "podman-compose"
    ];
    casks = [
      "librewolf"
      "raycast"
      "wezterm"

      "android-studio"
      "ollama"
      "utm"

      "openscad@snapshot"
      "steam"
      "ultimaker-cura"

      "coconutbattery"
    ];
  };
}
