{ rootPath, ... }:

{
  imports = builtins.map (p: rootPath + "/home" + p) [
    /env/home
  ];

  home.username = "christian";
}
