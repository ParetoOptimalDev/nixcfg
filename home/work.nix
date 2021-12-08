{ pkgs, inputs, system, ... }:

{
  imports = [
    ./env/work
    ./modules
    ./roles/common
    ./roles/desktop
    ./roles/dev
    ./roles/graphics
    ./roles/mobile
    ./roles/multimedia
    ./roles/office
    ./roles/ops
    ./roles/web
  ];
}
