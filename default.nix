{ pkgs ? import <nixpkgs> {} }:

rec {
  cntr = pkgs.callPackage ./cntr {};

  inxi = pkgs.callPackage ./inxi {};

  conky-symbols = pkgs.callPackage ./conky-symbols {};

  inconsolata-nerdfonts = pkgs.callPackage ./inconsolata-nerdfonts {};

  gdbgui-donation = pkgs.callPackage ./gdbgui {};

  frida-python = pkgs.callPackage ./frida-python {};

  eapol_test = pkgs.callPackage ./eapol_test {};

  xed = pkgs.callPackage ./xed { inherit mbuild; };
  mbuild = pkgs.callPackage ./mbuild {};

  modules = import ./modules;

  #inherit (callPackages ./node-packages {})
  #  typescript-language-server; # write-good
}
