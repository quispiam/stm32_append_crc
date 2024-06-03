{
  description = "Generate and append CRC32 checksum to STM32 application binaries";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: let

    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ] (system: function nixpkgs.legacyPackages.${system});

    in {

      packages = forAllSystems (pkgs: { 
        stm32_append_crc = pkgs.stdenv.mkDerivation {
          pname = "stm32_append_crc";
          version = "1.0.0";  # You can change this to the actual version if known

          src = ./src/.;

          buildInputs = [ pkgs.gcc9 ];

          buildPhase = ''
            gcc -o stm32_append_crc *.cpp *.c -lstdc++ 
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp stm32_append_crc $out/bin/
          '';
        };
      });
    };   
}
