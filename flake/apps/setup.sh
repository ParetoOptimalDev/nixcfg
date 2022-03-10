# shellcheck disable=SC1091
source @bashLib@

export -f _log

nix_config="@flakePath@"
export nix_config

_clone() {
    local name="${1}"
    local url="${2}"
    local directory="${3}"

    if [[ -d "${directory}" ]]; then
        _log "Not cloning ${name} because ${directory} already exists!"
        return
    fi

    _log "Clone ${name}..."
    su -c "git clone ${url} ${directory}" - "$(logname)"
}

# clone repos
if ! _is_nixos || _is_root; then
    _clone "nix-config" git@github.com:christianharke/nixcfg.git "${nix_config}"
fi

# generage age key
_generate_age() {
    local age_dir="${HOME}/.age"
    local age_key_file="${age_dir}/key.txt"
    if [[ ! -e "${HOME}/.age" ]]; then
        mkdir -p "${age_dir}"
        _log "Generating age key at ${age_key_file}"
        # shellcheck disable=SC2005
        echo "$(nix shell nixpkgs#age -c age-keygen -o "${age_key_file}" 2>&1)" |
            sed -e "s,^Public key: \(.*\)\$,$(hostname)-${USER} = \"\1\"," |
            tee -a "${nix_config}/.agenix.toml"
    else
        _log "Target directory ${age_dir} already exists, aborting age key generation!"
    fi
}
export -f _generate_age

# installation
_setup_nixos() {
    hostname=$(_read "Enter hostname" "$(hostname)")

    _generate_age
    su "$(logname)" -c "bash -c _generate_age"

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

    _generate_age

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
