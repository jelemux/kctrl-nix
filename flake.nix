{
  description = "kctrl";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];
      forEachSystem = nixpkgs.lib.genAttrs systems;

      pkgsBySystem = forEachSystem (
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        }
      );
    in
    {
      overlays.default = final: prev: { kctrl = final.callPackage ./package.nix {}; } ;

      packages = forEachSystem (system: rec {
        kctrl = pkgsBySystem.${system}.kctrl;
        default = kctrl;
      });
    };
}