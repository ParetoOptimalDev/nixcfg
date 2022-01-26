{ pkgs, inputs, system, ... }:

{
  imports = [
    ./modules
    ./roles/common
    ./roles/desktop
    ./roles/graphics
    ./roles/multimedia
    ./roles/office
    ./roles/ops
    ./roles/web
  ];
}
