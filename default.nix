{ pkgs ? import <nixpkgs> {} }:

rec {
  cntr = pkgs.callPackage ./pkgs/cntr {};

  inxi = pkgs.callPackage ./pkgs/inxi {};

  conky-symbols = pkgs.callPackage ./pkgs/conky-symbols {};

  inconsolata-nerdfonts = pkgs.callPackage ./pkgs/inconsolata-nerdfonts {};

  gdbgui-donation = pkgs.callPackage ./pkgs/gdbgui {};

  frida-python = pkgs.callPackage ./pkgs/frida-python {};

  eapol_test = pkgs.callPackage ./pkgs/eapol_test {};

  xed = pkgs.callPackage ./pkgs/xed { inherit mbuild; };
  mbuild = pkgs.callPackage ./pkgs/mbuild {};

  modules = import ./modules;

  #inherit (callPackages ./node-packages {})
  #  typescript-language-server; # write-good
}
