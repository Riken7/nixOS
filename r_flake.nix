{
  description = "Rust development environment flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { self, nixpkgs , rust-overlay }:
    let
      system = "x86_64-linux";
      overlays = [(import rust-overlay)];
      pkgs = nixpkgs.legacyPackages.${system};
      rust = pkgs.rust-bin.stable.latest.default;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          pkg-config
          rustc
          cargo
          cargo-tauri
          gcc
          cargo-watch
          nodejs
          gobject-introspection
          openssl
        ];
        buildInputs = with pkgs; [
          at-spi2-atk
          atkmm
          cairo
          gdk-pixbuf
          glib
          gtk3
          harfbuzz
          librsvg
          libsoup_3
          pango
          webkitgtk_4_1
        ];
        #shellHook = ''
        #  for pkg in rustc cargo gcc openssl pkg-config; do
        #    echo "Using $pkg: $(which $pkg)"
        #  done
        #'';
        PKG_CONFIG_PATH = "${pkgs.glib.dev}/lib/pkgconfig";
        shellHook = ''
          echo "Rust Compiler: $(rustc --version)"
          echo "Cargo Version: $(cargo --version)"
          echo "Node.js Version: $(node --version)"
          echo "Using OpenSSL from: $OPENSSL_LIB_DIR"
        '';
      };
    };
}
