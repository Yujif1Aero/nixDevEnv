{
  description = "base-tool-nixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; # 特定のバージョンを指定
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true; # ROCmなどの非フリーパッケージを利用する場合に必要
          };
        };
      in
      {
        devShells.base = pkgs.mkShell {
          buildInputs = [
            pkgs.gcc13
            pkgs.curl
            pkgs.python313

            # ここにROCmのパッケージを追加
            # pkgs.rocmPackages.rpp
            # pkgs.rocmPackages.clr
            # pkgs.rocmPackages.hipcc
#            pkgs.rocmPackages
            # 必要に応じて他のROCm関連パッケージを追加

            pkgs.gnumake
          ];
        };
      }
    );
}
