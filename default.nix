{ callPackage, callPackages }:

rec {
  cntr = callPackage ./cntr {};

  inxi = callPackage ./inxi {};

  conky-symbols = callPackage ./conky-symbols {};

  inconsolata-nerdfonts = callPackage ./inconsolata-nerdfonts {};

  gdbgui-donation = callPackage ./gdbgui {};

  frida-python = callPackage ./frida-python {};

  xed = callPackage ./xed { inherit mbuild; };
  mbuild = callPackage ./mbuild {};

  modules = import ./modules;

  #inherit (callPackages ./node-packages {})
  #  typescript-language-server; # write-good
}
