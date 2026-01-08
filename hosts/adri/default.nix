{
  pkgs,
  lib,
  username,
  self,
  ...
}:

let
  humanlayer = pkgs.callPackage ../../pkgs/humanlayer.nix { };
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # Existing
    neofetch
    vim
    opencode
    humanlayer

    # CLI tools (migrated from Homebrew)
    btop
    coreutils
    direnv
    gh
    go
    bun
    lazydocker
    neovim
    netbird
    nodejs
    podman
    rclone
    rustup
    sshpass
    freetds

    # Development tools for Nix
    statix # Nix linter
    nixpkgs-fmt # Nix formatter
    deadnix # Find unused Nix code
    nix-tree # Browse Nix dependencies
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Allow user to manage binary caches (needed for devenv cachix)
  nix.settings.trusted-users = [ "root" username ];

  users.users.${username} = {
    home = "/Users/${username}";
  };

  # Required for homebrew and other user-specific features
  system.primaryUser = username;

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # NetBird VPN daemon service
  launchd.daemons.netbird = {
    serviceConfig = {
      Label = "io.netbird.client";
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "/bin/wait4path /nix/store && /bin/mkdir -p /var/run/netbird && exec /run/current-system/sw/bin/netbird service run"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/var/log/netbird/client.log";
      StandardErrorPath = "/var/log/netbird/client.error.log";
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
