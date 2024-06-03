{
  description = "Generate and append CRC32 checksum to STM32 application binaries";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let

      system = "x86_64-linux";  # Change this if you're using a different architecture
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    #forAllSystems = function:
    #  nixpkgs.lib.genAttrs [
    #    "x86_64-linux"
    #    "aarch64-linux"
    #  ] (system: function nixpkgs.legacyPackages.${system});
    #in {

      #packages = forAllSystems (pkgs: { 
        #default = pkgs.callPackage ./package.nix {};
        pname = "stm32_append_crc";
        version = "1.0.0";  # You can change this to the actual version if known

        src = ./.;

        buildInputs = [ pkgs.gcc pkgs.libstdcxx ];

        buildPhase = ''
          gcc -o stm32_append_crc *.cpp *.c -lstdc++
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp stm32_append_crc $out/bin/
        '';
    };
}
