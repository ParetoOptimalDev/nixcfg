{ lib, rootPath, ... }:

{
  imports = builtins.map lib.custom.mkHomePath [
    /env/home
  ];

  home.username = "christian";
}
