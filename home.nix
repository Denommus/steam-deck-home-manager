{ config, pkgs, lib, ... }:
let
  myAspell = pkgs.aspellWithDicts (d: [d.en d.pt_BR]);
in
{
  home.username = "deck";
  home.homeDirectory = "/run/media/mmcblk0p1/nix/home";
  home.stateVersion = "22.05";

  home.packages = (with pkgs; [
    myAspell
    nix
    nettools
    bashInteractive
    rustup
    rust-analyzer
    fira-code
    fira-code-symbols
    texlive.combined.scheme-full
    python310Packages.pygments
  ]);

  home.sessionPath = [
    "/run/media/mmcblk0p1/nix/home/.local/share/solana/install/active_release/bin"
  ];
  home.sessionVariables = {
    NEON_REVISION = 1;
  };

  programs.home-manager.enable = true;
  programs.emacs.enable = true;
  programs.emacs.init = import ./emacs/emacs.nix { inherit pkgs; };
  programs.emacs.package = pkgs.emacs.override {
    nativeComp = true;
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      . "${config.home.profileDirectory}/etc/profile.d/nix.sh"
    '';
  };

  programs.git = {
    enable = true;
    ignores = [ "*~" ];
    lfs.enable = true;
    userEmail = "yuridenommus@gmail.com";
    userName = "Yuri Albuquerque";
    extraConfig = {
      pull.ff = "only";
      init.defaultBranch = "main";
    };
  };

  fonts.fontconfig.enable = true;
}
