{ pkgs }:

pkgs.buildGo123Module rec {
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

  meta = {
    description = "Command-line utility for kapp-controller";
    homepage = "https://carvel.dev/kapp-controller/";
    mainProgram = "kctrl";
  };
}