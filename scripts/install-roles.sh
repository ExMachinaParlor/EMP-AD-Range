#!/usr/bin/env bash
# Install all roles this range needs into Ludus, then load the range config.
# Role-install commands verified on ludusv4 (Ludus 2.x).
# Collections (ansible.windows, community.windows, microsoft.ad) ship globally with Ludus.
set -uo pipefail
cd "$(dirname "$0")/.."

# Galaxy role
ludus ansible role add geerlingguy.apache --force || echo "[!] geerlingguy.apache add failed"

# Local roles (from directory)
for r in ./roles/*/; do
  ludus ansible role add -d "$r" --force || echo "[!] failed: $r"
done

ludus ansible role list

# Load the range config
ludus range config set -f range-config.yml
echo "[+] Roles installed and config set. Deploy with: ludus range deploy"
