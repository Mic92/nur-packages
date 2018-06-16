{ callPackage, callPackages }:

{
  cntr = callPackage ./cntr {};
  inxi = callPackage ./inxi {};

  conky-symbols = callPackage ./conky-symbols {};

  inconsolata-nerdfonts = callPackage ./inconsolata-nerdfonts {};

  gdbgui-donation = callPackage ./gdbgui {};

  #inherit (callPackages ./node-packages {})
  #  typescript-language-server; # write-good
}
