# NixOS Configurations

# Initial NixOS installation

To install NixOS on a fresh machine, run:

```bash
$ wget https://raw.githubusercontent.com/christianharke/nixos-config/master/scripts/nixos-install.sh \
  | sudo bash -s -- <hostname> <disk>
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

## Setup on existing OS

```bash
$ # On NixOS
$ sudo ./scripts/nixos-setup.sh

$ # On non-NixOS
$ ./scripts/nix-setup.sh
```

## Rebuilding / Updating / ...

tdb
