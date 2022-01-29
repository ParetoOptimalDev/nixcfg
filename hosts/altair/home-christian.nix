{ lib, rootPath, ... }:

{
  imports = [
    (rootPath + "/home/env/home")
    (rootPath + "/home/roles/gaming")
  ];

  home.username = "christian";
}
