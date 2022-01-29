{ rootPath, ... }:

{
  imports = [
    (rootPath + "/home/env/work")
    (rootPath + "/home/roles/dev")
    (rootPath + "/home/roles/mobile")
  ];

  home.username = "christian";
}
