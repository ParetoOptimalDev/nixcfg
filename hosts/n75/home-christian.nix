{ rootPath, ... }:

{
  imports = [
    #builtins.map (p: rootPath + "/home" + p) [
    (rootPath + "/home/env/work")
    #"/roles/dev"
    #"/roles/mobile"
  ];

  home.username = "christian";
}
