{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./opencode.nix
  ];

  home.stateVersion = "23.11";
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Enable XDG Base Directory support
  xdg.enable = true;

  # Shell configuration with convenient aliases
  programs.zsh = {
    enable = true;
    shellAliases = {
      # Quick rebuild
      dr = "darwin-rebuild switch --flake ~/.config/nix";
      drb = "darwin-rebuild build --flake ~/.config/nix";
      
      # Update and rebuild
      dru = "cd ~/.config/nix && nix flake update && darwin-rebuild switch --flake .";
      
      # Preview what will change
      drn = "darwin-rebuild build --flake ~/.config/nix && nix store diff-closures /run/current-system ./result";
      
      # Edit config
      dre = "cd ~/.config/nix && $EDITOR flake.nix";
    };
  };
}
