{ lib, pkgs, ... }:

{
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      cargo
      clang
      clang-tools
      cmake
      go
      lldb
      nodejs
      rust-analyzer
      rustfmt
      ;

    inherit
      (pkgs.luaPackages)
      lua
      ;
    
    inherit
      (pkgs.nodePackages_latest)
      prettier
      typescript-language-server
      vscode-langservers-extracted
      yarn
      ;
  };
}
