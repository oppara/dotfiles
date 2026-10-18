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
    agent-skills = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ax = {
      url = "github:yusukebe/ax";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur-babarot,
      agent-skills,
      ax,
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
          ax-pkg = ax.packages.${system}.default;
          inputs = { inherit ax; };
        };
        modules = [
          agent-skills.homeManagerModules.default
          ./home.nix
        ];
      };
    };
}
