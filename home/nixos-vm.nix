{ pkgs, inputs, system, ... }:

{
  imports = [
    ./env/home
    ./modules
    ./roles/common
    ./roles/desktop
    ./roles/office
  ];
}
