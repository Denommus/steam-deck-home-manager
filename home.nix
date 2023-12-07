{ config, pkgs, lib, ... }:
let
  myAspell = pkgs.aspellWithDicts (d: [d.en d.pt_BR]);
in
{
  home.username = "deck";
  home.stateVersion = "22.05";
  home.homeDirectory = "/home/deck";

  home.packages = (with pkgs; [
    myAspell
    nix
    nettools
    bashInteractive
    rustup
    fira-code
    fira-code-symbols
    texlive.combined.scheme-full
    python310Packages.pygments
    exercism
    stack
    openjdk
    plantuml
  ]);

  home.sessionVariables = {
    PATH = "/home/deck/.local/share/solana/install/active_release/bin:$PATH";
  };

  programs.home-manager.enable = true;
  programs.emacs.enable = true;
  programs.emacs.init = import ./emacs/emacs.nix { inherit pkgs; };
  programs.emacs.package = pkgs.emacs29.override {
    withNativeCompilation = true;
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
      github.user = "Denommus";
    };
  };

  fonts.fontconfig.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.extended = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "sudo"
      ];
    };
  };
}
