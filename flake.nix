{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can change the word unstable to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ytm-player = {
      url = "github:peternaame-boop/ytm-player";	
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ytm-player, chaotic, ... }: {
    nixosConfigurations.nixbook-air = nixpkgs.lib.nixosSystem {
      modules = [ 
      ./configuration.nix
      home-manager.nixosModules.default
      chaotic.nixosModules.default
      {
      	nixpkgs.overlays = [ ytm-player.overlays.default ];
      	home-manager = {
      	  useGlobalPkgs = true;
      	  useUserPackages = true;
      	  users.cig0073 = ./home.nix; # replace <USERNAME> with your actual username
      	};
      }];
    };
  };
}

