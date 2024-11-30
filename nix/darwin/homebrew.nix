{ ... }:

{
  homebrew = {
    enable = true;

    taps = [];
    brews = [
      "cocoapods"
      "xcodes"

      "podman" "podman-compose"
      "qemu"
    ];
    casks = [
      "librewolf"
      "raycast"
      "wezterm"
      "hammerspoon"

      "element"

      "android-studio"
      "ollama"
      "utm"

      "iina"
      "skim"
      "openscad@snapshot"
      "steam"
      "ultimaker-cura"

      "coconutbattery"
    ];
  };
}
