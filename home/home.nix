{ pkgs, inputs, system, ... }:

{
  imports = [
    ./env/home
    ./modules
    ./roles/common
    ./roles/desktop
    ./roles/gaming
    ./roles/graphics
    ./roles/multimedia
    ./roles/office
    ./roles/ops
    ./roles/web
  ];
}
