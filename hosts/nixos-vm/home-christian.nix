{ rootPath, ... }:

{
  imports = [
    (rootPath + "/home/env/home")
  ];

  home.username = "christian";
}
