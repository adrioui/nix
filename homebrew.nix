{
  config,
  lib,
  pkgs,
  ...
}:

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
    "firefox"
    "font-hack-nerd-font"
    "ghostty"
    "obsidian"
    "orbstack"
    "warp"
    "zed"
    "yoink"
    "anydesk"
    "typora"
  ];

  homebrew.brews = [
    "steveyegge/beads/bd"
  ];

}
