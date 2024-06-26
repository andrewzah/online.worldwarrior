let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/dd457de7e08c6d06789b1f5b88fc9327f4d96309.tar.gz";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  caddyfile = pkgs.writeTextDir "/etc/caddy/Caddyfile" (builtins.readFile ./Caddyfile);
in
rec {
  img = pkgs.dockerTools.buildImage {
    name = "docker.io/andrewzah/online.worldwarrior";
    tag = "0.5.1";

    copyToRoot = pkgs.buildEnv {
      name = "img-root";
      paths = with pkgs; [
        caddy
        caddyfile

        (pkgs.callPackage ./website.nix {})
      ];
    };

    config = {
      Cmd = [ "caddy" "run" "--config" "/etc/caddy/Caddyfile" "--adapter"  "caddyfile" ];
      ExposedPorts = {
        "2020" = {};
      };
    };
  };
}
