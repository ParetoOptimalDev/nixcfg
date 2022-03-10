# :snowflake: Nix Configuration

[![NixOS][nixos-badge]][nixos]
[![Build and Test][ci-badge]][ci]
[![Update][update-badge]][update]

## Features

* Automation scripts to setup a fresh [NixOS machine from scratch](flake/apps/nixos-install.sh) or
  an [arbitrary preinstalled Linux machine](flake/apps/setup.sh) easily
* Secret management in [NixOS][nixos] ([agenix][agenix]) and [home-manager][home-manager]
  ([homeage][homeage]) with [age][age]
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

After rebooting proceed with the [next section](#initial-setup).

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

# Set up this Nix configuration
nix run github:christianharke/nixcfg#setup

# set login shell
chsh -s /bin/zsh
```

### Make secrets available on new host

The setup script will create the [age][age] keys needed and put them in the
[.agenix.toml](.agenix.toml) file, where it then needs to be assigned to the appropriate groups.
Push the updated `.agenix.toml` back to the git repository, pull it to an existing host and
re-key all the secrets with the command:

```bash
sudo agenix -i /root/.age/key.txt -i ~/.age/key.txt -r -vv
```

After pushing/pulling the re-keyed secrets, just [run a rebuild](#rebuilding) of the new host's
config for decrypting them.

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

[ci]: https://github.com/christianharke/nixcfg/actions/workflows/ci.yml
[ci-badge]: https://github.com/christianharke/nixcfg/actions/workflows/ci.yml/badge.svg
[update]: https://github.com/christianharke/nixcfg/actions/workflows/update.yml
[update-badge]: https://github.com/christianharke/nixcfg/actions/workflows/update.yml/badge.svg

[age]: https://age-encryption.org/
[agenix]: https://github.com/ryantm/agenix
[home-manager]: https://github.com/nix-community/home-manager
[homeage]: https://github.com/jordanisaacs/homeage
[nixos]: https://nixos.org/
[nixos-badge]: https://img.shields.io/badge/NixOS-21.11-blue.svg?logo=NixOS&logoColor=white
[nixpkgs-fmt]: https://github.com/nix-community/nixpkgs-fmt
[shellcheck]: https://github.com/koalaman/shellcheck

