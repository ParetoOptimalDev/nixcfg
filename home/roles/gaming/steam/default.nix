{ pkgs, ... }:

{
  home.packages = [
    pkgs.steam
  ];

  xdg.dataFile =
    let
      userId = "5051778";
      appIds = {
        csgo = "730";
      };
    in
    {
      "Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/autoexec.cfg".source = ./data/autoexec.cfg;
      "Steam/userdata/${userId}/${appIds.csgo}/local/cfg/myconf.cfg".source = ./data/myconf.cfg;
    };
}
