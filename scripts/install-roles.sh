#!/usr/bin/env bash
# Install all roles/collections this range needs into Ludus, then load the config.
# Verify each flag with `ludus <cmd> --help` on your Ludus version before running.
set -euo pipefail
cd "$(dirname "$0")/.."

# Galaxy role
ludus ansible role add geerlingguy.apache

# Collections used by ludus-emprange-fileserver (normally already on the Ludus host)
for c in ansible.windows community.windows microsoft.ad; do
  ludus ansible collection add "$c" || echo "[!] collection $c: add failed or already installed"
done

# Local roles (from directory)
ludus ansible role add -d ./roles/ludus-emprange-fileserver
ludus ansible role add -d ./roles/ludus-emprange-web

ludus ansible role list

# Load the range config
ludus range config set -f range-config.yml
echo "[+] Roles installed and config set. Deploy with: ludus range deploy"
