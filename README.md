# :snowflake: Nix Configuration

![ci](https://github.com/christianharke/nixcfg/actions/workflows/ci.yml/badge.svg)
![update](https://github.com/christianharke/nixcfg/actions/workflows/update.yml/badge.svg)

## Features

* Automation scripts to setup a fresh [NixOS machine from scratch](flake/apps/nixos-install.sh) or an [arbitrary preinstalled Linux machine](flake/apps/setup.sh) easily
* Generated shell scripts are always linted with [shellcheck][shellcheck]
* Checks source code with [shellcheck][shellcheck] and [nixpkgs-fmt][nixpkgs-fmt]
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

To install NixOS from the ISO of [nixos.org][nixos] on a fresh machine, run:

```bash
# If nix version < 2.4, run:
nix-shell -p nixFlakes

sudo su # become root
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

nix run github:christianharke/nixcfg#nixos-install -- <hostname> <disk>
```

Where:

* `<hostname>` is your target machine's desired host name. Define it beforehand inside
  `nixosConfigurations` of `flake.nix`.
* `<disk>` is your target drive to install NixOS on. Accepted values are `/dev/sda`, `/dev/nvme0n1`
  or the like.

This will completely *nuke* all the data on your `<disk>` device provided. Make sure to have a
working backup from your data of all drives connected to your target machine.

**Warning:** Even if the script *should* ask you before committing any changes to your machine,
it can unexpectedly cause great harm!

## Initial Setup

### NixOS

```bash
$ sudo nix run github:christianharke/nixcfg#setup
```

### Non-NixOS

```bash
# install Nix
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
sh <(curl -L https://nixos.org/nix/install) --no-channel-add --no-modify-profile
. ~/.nix-profile/etc/profile.d/nix.sh

# Set up this Nix config
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
[nixpkgs-fmt]: https://github.com/nix-community/nixpkgs-fmt
[shellcheck]: https://github.com/koalaman/shellcheck
