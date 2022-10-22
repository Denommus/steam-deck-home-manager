{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };
  outputs = { self, nixpkgs, hm, nur }:
    let
      nur-no-pkgs = (system: import nur {
        pkgs = null;
        nurpkgs = import nixpkgs {
          inherit system;
        };
      });
    in
  {
    homeConfigurations.deck = hm.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
        (nur-no-pkgs "x86_64-linux").repos.rycee.hmModules.emacs-init
      ];
    };
  };
}
