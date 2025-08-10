{ ... }:

{
  homebrew = {
    enable = true;

    taps = [
      "d12frosted/emacs-plus"
      "smudge/smudge"
    ];
    brews = [
      "cocoapods"
      "xcodes"
      "nightlight"

      # NOTE: this is just here to try some editors. pull when decided
      "kakoune"
      "helix"

      # TODO: remove these when p2pool on nix is fixed
      "monero"
      "libuv" "zmq" "libpgm"  # p2pool dependencies
      "xmrig"

      "kanata"
      "podman" "podman-compose"
      "qemu"
      "scrcpy"
      "wireguard-tools"
    ];
    casks = [
      "librewolf"
      "raycast"
      "wezterm"
      "rectangle"

      "discord"
      "element"
      "slack"

      "android-studio"
      "obs"
      "ollama"
      "utm"

      # "iina"  # disabled for manually compiled `macos-tahoe` branch
      "cog-app"
      "skim"
      "openscad@snapshot"
      "steam"

      "ultimaker-cura"
      "orcaslicer"

      "coconutbattery"
    ];
  };
}
