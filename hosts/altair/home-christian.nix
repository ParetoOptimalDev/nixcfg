{ rootPath, ... }:

{
  imports = builtins.map (p: rootPath + "/home" + p) [
    /env/home
    /roles/gaming
    /roles/mobile
  ];

  home.username = "christian";
}
