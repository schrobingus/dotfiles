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

      "android-studio"
      "ollama"
      "utm"

      "iina"
      "openscad@snapshot"
      "steam"
      "ultimaker-cura"

      "coconutbattery"
    ];
  };
}
