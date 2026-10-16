{
  description = "Home Manager configuration of oppara";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-babarot = {
      url = "github:babarot/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur-babarot,
      ...
    }:
    let
      system = "aarch64-darwin";
    in
    {
      homeConfigurations.oppara = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          nur-babarot = nur-babarot.packages.${system};
        };
        modules = [ ./home.nix ];
      };
    };
}
