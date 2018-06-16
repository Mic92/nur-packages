{ callPackage, callPackages }:

{
  cntr = callPackage ./cntr {};
  inxi = callPackage ./inxi {};

  conky-symbols = callPackage ./conky-symbols {};

  inconsolata-nerdfonts = callPackage ./inconsolata-nerdfonts {};

  # patched to unlock "full" version
  gdbgui = gdbgui.overrideAttrs (old: {
    patches = [ ./gdbgui.patch ];
  };

  #inherit (callPackages ./node-packages {})
  #  typescript-language-server; # write-good
}
