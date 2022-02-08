# shellcheck disable=SC1091
source @bashLib@

nix_config="@flakePath@"

_clone() {
    local name="${1}"
    local url="${2}"
    local directory="${3}"

    if [[ -d "${directory}" ]]; then
        _log "Not cloning ${name} because ${directory} already exists!"
        return
    fi

    _log "Clone ${name}..."
    git clone "${url}" "${directory}"
}

# clone repos
if ! _is_nixos || _is_root; then
    _clone "nix-config" git@github.com:Gerschtli/nix-config.git "${nix_config}"
fi


# installation
_setup_nixos() {
    hostname_current=$(hostname)
    hostname=$(_read "Enter hostname [${hostname_current}]")
    hostname=${hostname:-${hostname_current}}

    _log "Linking flake to system config..."
    ln -fs "${nix_config}/flake.nix" /etc/nixos/flake.nix

    _log "Run nixos-rebuild for host ${hostname}..."
    nixos-rebuild switch --keep-going --flake "${nix_config}#${hostname}"
}

_setup_nix() {
    has_nix_imperative=$(nix-env -q --json | jq ".[].pname" | grep '"nix"' > /dev/null)
    # preparation for non nixos systems
    if ${has_nix_imperative}; then
        _log "Set priority of installed nix package..."
        nix-env --set-flag priority 1000 nix
    fi

    _log "Build home-manager activationPackage..."
    nix build "${nix_config}#homeConfigurations.$(logname)@$(hostname).activationPackage"

    _log "Run activate script..."
    HOME_MANAGER_BACKUP_EXT=hm-bak ./result/activate

    rm -v result

    # clean up
    if ${has_nix_imperative}; then
        _log "Uninstall manual installed nix package..."
        nix-env --uninstall nix
    fi
}

if _is_nixos && _is_root; then
    _setup_nixos
elif ! _is_nixos && ! _is_root; then
    _setup_nix
else
    _log "You need to be root on NixOS or non-root on non-NixOS! Aborting..."
fi

echo
