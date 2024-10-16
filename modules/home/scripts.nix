{ pkgs, host, username, ... }:
{
  home.packages = [

    (pkgs.writeShellScriptBin "checkbat" ''
     cat /sys/class/power_supply/BAT0/capacity
     '')

    (pkgs.writeShellScriptBin "switch-config" ''
     sudo nixos-rebuild switch --flake /home/${username}/.dotfiles#${host}
     '')

    (pkgs.writeShellScriptBin "upgrade-switch" ''
     sudo nixos-rebuild switch --upgrade --flake /home/${username}/.dotfiles#${host}
     '')

    (pkgs.writeShellScriptBin "update-flake" ''
     sudo nix flake update ~/.dotfiles#
     '')

    (pkgs.writeShellScriptBin "nix-clean" ''
      nix-collect-garbage --delete-older-than 15d
     '')

    (pkgs.writeShellScriptBin "nvopen" ''
     kitty nvim $1
    '')

    (pkgs.writeShellScriptBin "Nvim" ''
     kitty nvim $1
    '')
  ];
}
