{ lib, rootPath, ... }:

{
  imports = builtins.map lib.custom.mkHomePath [
    /env/work
    /roles/dev
    /roles/mobile
  ];

  home.username = "christian";
}
