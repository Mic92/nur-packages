{ system ? builtins.currentSystem, pkgs ? import <nixpkgs> { inherit system; } }:

rec {
  vaultwarden_ldap = pkgs.callPackage ./pkgs/vaultwarden_ldap { };

  # TODO checksum can break ... make a mirror?
  # binary-ninja = pkgs.callPackage ./pkgs/binary-ninja {};

  cntr = pkgs.callPackage ./pkgs/cntr { };

  conky-symbols = pkgs.callPackage ./pkgs/conky-symbols { };

  clearsans = pkgs.callPackage ./pkgs/clearsans { };

  drone-runner-ssh = pkgs.callPackage ./pkgs/drone-runner-ssh { };

  eapol_test = pkgs.callPackage ./pkgs/eapol_test { };

  fira-code-pro-nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" ];
  };

  gatttool = pkgs.callPackage ./pkgs/gatttool { };

  gdb-dashboard = pkgs.callPackage ./pkgs/gdb-dashboard { };

  goatcounter = pkgs.callPackage ./pkgs/goatcounter { };

  grimshot = pkgs.callPackage ./pkgs/grimshot { };

  hello-nur = pkgs.callPackage ./pkgs/hello-nur { };

  irc-announce = pkgs.callPackage ./pkgs/irc-announce { };

  ircsink = pkgs.callPackage ./pkgs/ircsink { };

  kvmtool = pkgs.callPackage ./pkgs/kvmtool { };

  linux_ayufan_5_6 = pkgs.callPackage ./pkgs/linux_ayufan_5_6 {
    kernelPatches = with pkgs; [
      kernelPatches.bridge_stp_helper
      kernelPatches.request_key_helper
    ];
  };
  #linux_ayufan_5_9 = pkgs.callPackage ./pkgs/linux_ayufan_5_9 {
  #  kernelPatches = with pkgs; [
  #    kernelPatches.bridge_stp_helper
  #    kernelPatches.request_key_helper
  #  ];
  #};
  #linux_ayufan_5_11 = pkgs.callPackage ./pkgs/linux_ayufan_5_11 {
  #  kernelPatches = with pkgs; [
  #    kernelPatches.bridge_stp_helper
  #    kernelPatches.request_key_helper
  #  ];
  #};
  linux_ayufan = linux_ayufan_5_6;

  linuxPackages_ayufan_5_6 = pkgs.linuxPackagesFor linux_ayufan_5_6;
  linuxPackages_ayufan = linuxPackages_ayufan_5_6;

  lualdap = pkgs.callPackage ./pkgs/lualdap { };

  mastodon-hnbot = pkgs.python39Packages.callPackage ./pkgs/mastodon-hnbot {
    inherit (python3Packages) Mastodon;
  };

  mypyls = pkgs.python39.pkgs.callPackage ./pkgs/mypyls { };

  mosh-ssh-agent = pkgs.callPackage ./pkgs/mosh-ssh-agent { };

  nixpkgs-review-unstable = pkgs.callPackage ./pkgs/nixpkgs-review { };
  # compatibility
  nix-review-unstable = nixpkgs-review-unstable;

  inherit (pkgs.callPackages ./pkgs/nix-build-uncached { })
    nix-build-uncached
    nix-build-uncached-flakes;

  pandoc-bin = pkgs.callPackage ./pkgs/pandoc { };

  patool = pkgs.python39.pkgs.callPackage ./pkgs/patool {
    inherit (pkgs) libarchive;
  };

  peep = pkgs.callPackage ./pkgs/peep { };

  perlPackages = {
    Pry = pkgs.callPackage ./pkgs/pry { };
  };

  python3Packages = pkgs.recurseIntoAttrs (
    pkgs.python3Packages.callPackage ./pkgs/python-pkgs {}
  );

  pyps4-2ndscreen = pkgs.python39.pkgs.toPythonApplication python3Packages.pyps4-2ndscreen;

  rspamd-learn-spam-ham = pkgs.python39.pkgs.callPackage ./pkgs/rspam-learn-spam-ham { };

  rhasspyPackages = import ./pkgs/rhasspy {
    inherit (pkgs.python39Packages) callPackage;
    inherit (python3Packages) deepspeech;
  };

  inherit (rhasspyPackages) rhasspy;

  signald = pkgs.callPackage ./pkgs/signald { };

  weechat-signal = pkgs.callPackage ./pkgs/weechat-signal { };

  inherit (pkgs.callPackages ./pkgs/node-packages { }) speedscope reveal-md;

  source-code-pro-nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "SourceCodePro" ];
  };

  traceshark = pkgs.qt5.callPackage ./pkgs/traceshark { };

  tmux-thumbs = pkgs.callPackage ./pkgs/tmux-thumbs { };

  threema-web = pkgs.callPackage ./pkgs/threema-web { };

  untilport = pkgs.callPackage ./pkgs/untilport { };

  yubikey-touch-detector = pkgs.callPackage ./pkgs/yubikey-touch-detector { };

  noise-suppression-for-voice = pkgs.callPackage ./pkgs/noise-suppression-for-voice { };

  mailexporter = pkgs.callPackage ./pkgs/mailexporter { };

  modules = import ./modules;
}
