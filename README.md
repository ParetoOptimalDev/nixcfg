# Nix Configuration

## Features

* Automation scripts to setup a fresh [NixOS machine from scratch](scripts/nixos-install.sh) or an [arbitrary preinstalled Linux machine](flake/apps/setup.sh) easily
* Weekly automatic flake input updates committed to master when CI passes

## Supported configurations

* [NixOS][nixos]-managed
  * `altair` (private desktop)
  * `n75` (work laptop)
  * `nixos-vm` (test VM)
* [home-manager][home-manager]-managed
  * `dev-vm` with CentOS Stream (work VM)

See [flake.nix](flake.nix) for more information like `system`.

# Initial NixOS installation

To install NixOS on a fresh machine, run:

```bash
$ curl -s https://raw.githubusercontent.com/christianharke/nixcfg/master/scripts/nixos-install.sh > nixos-install.sh

$ # If nix version < 2.4, run:
$ nix-shell -p nixFlakes

$ sudo bash nixos-install.sh <hostname> <disk>
```

Where:

* `<hostname>` is your target machine's desired host name. Define it beforehand inside
  `nixosConfigurations` of `flake.nix`.
* `<disk>` is your target drive to install NixOS on. Accepted values are `/dev/sda`, `/dev/nvme0n1`
  or the like.

This will completely *nuke* all the data on your `<disk>` device provided. Make sure to have a
working backup from your data of all drives connected to your target machine.

**Warning:** Even if the script *should* ask you beforehand committing any changes to your machine,
it can unexpectedly cause great harm!

## Initial Setup

### NixOS

```bash
$ sudo nix run github:christianharke/nixcfg#setup
```

### Non-NixOS

```bash
# install nix setup
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
sh <(curl -L https://nixos.org/nix/install) --no-channel-add --no-modify-profile
. ~/.nix-profile/etc/profile.d/nix.sh
nix run github:christianharke/nixcfg#setup
# set login shell
chsh -s /bin/zsh
```

## Updating

```bash
$ nix flake update
```

## Rebuilding

```bash
$ # On NixOS
$ sudo nixos-rebuild switch

$ # On non-NixOS
$ hm-switch
```

[home-manager]: https://github.com/nix-community/home-manager
[nixos]: https://nixos.org/
