{ lib, rootPath, ... }:

{
  imports = builtins.map lib.custom.mkHomePath [
    /env/home
    /roles/gaming
  ];

  home.username = "christian";
}
