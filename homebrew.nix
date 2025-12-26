{ config, lib, pkgs, ... }:

{
  # Enable Homebrew integration
  # NOTE: Homebrew must be installed manually first:
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  homebrew.enable = true;

  # Declarative cleanup - removes anything not declared here
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
  };

  # GUI applications only - CLI tools go in environment.systemPackages
  homebrew.casks = [
    "dbeaver-community"
    "discord"
    "font-hack-nerd-font"
    "ghostty"
    "obsidian"
    "orbstack"
    "warp"
    "zed"
  ];

  # Not using brews - all CLI tools managed via Nix
  # homebrew.brews = [ ];

  # No additional taps needed for current casks
  # homebrew.taps = [ ];
}
