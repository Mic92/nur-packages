{ callPackage }:
{
  jupyterthemes = callPackage ./jupyterthemes.nix {};

  gatt = callPackage ./gatt.nix { };

  pry = callPackage ./pry.nix { };

  priority = callPackage ./priority.nix { };
}
