{ rootPath, ... }:

{
  imports = builtins.map (p: rootPath + "/home" + p) [
    /env/work
    /roles/dev
    /roles/mobile
  ];

  home.username = "christian";
}
