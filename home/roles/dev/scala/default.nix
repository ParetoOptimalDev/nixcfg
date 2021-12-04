{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ammonite # REPL
    sbt
  ];

  xdg.configFile."sbt/0.13/plugins/plugins.sbt".source = ./config/0.13/plugins/plugins.sbt;
  xdg.configFile."sbt/1.0/plugins/plugins.sbt".source = ./config/1.0/plugins/plugins.sbt;
}
