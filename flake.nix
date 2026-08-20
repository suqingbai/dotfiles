{
  description = "dotfiles";

  inputs = {
    # Use the standard NixOS release branch for Linux instead of the darwin branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    herdr.url = "github:herdrdev/herdr/v0.8.0";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, herdr, nixgl,... }:
    let
      user = "sue";
      # Define your architecture (Standard 64-bit Linux)
      system = "x86_64-linux";
      # allow unfree packages (like claude-code) to be installed
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # This defines a standalone Home Manager configuration
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass custom variables (like 'user') to your home.nix module
        extraSpecialArgs = {
          inherit user;
          herdr-pkg = herdr.packages.${system}.default;
          nixgl-intel = nixgl.packages.${system}.nixGLIntel;
        };

        modules = [
          ./home.nix
        ];
      };
    };
}