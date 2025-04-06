{
  description = "kctrl";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      packages = forAllSystems ({ pkgs }: {
        default = pkgs.buildGo123Module rec {
          pname = "kctrl";
          version = "0.55.1";
          subPackages = [ "cmd/kctrl" ];
          src = pkgs.fetchFromGitHub {
            owner = "carvel-dev";
            repo = "kapp-controller";
            rev = "refs/tags/v${version}";
            sha256 = "sha256-IdXar43GPCz+tYfKG0vumMyIOj8s+HHxa+PrmKMNmE8=";
          } + "/cli";
          vendorHash = null;
        };
      });
    };
}