```bash
#!/usr/bin/env bash
# Niveau: atelier
# Objectif: transformation de texte avec sed/awk
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

# Préparer fichier texte confus
cat > rapport.txt <<'RPT'
Nom: Pad;Score:?;Date:??
Nom: Bash;Score:42;Date:2025-01-01
Nom: Oublie;Score:10;Date:2024-12-31
RPT

cat <<'TASK'

NIVEAU 4 — atelier
Pad Bash a un rapport mal formé. Normalise-le : produire un CSV 'rapport.csv' avec les colonnes Nom,Score,Date séparées par des virgules, sans espaces.
Ex: Pad,0,2025-01-01

Indices: utilisez sed/awk/grep selon vos préférences.

TASK

tries=0
while true; do
    echo
    cmd=$(prompt_command_capture)
    tries=$((tries+1))
    if [[ "$cmd" =~ ^(rm|reboot|shutdown|dd|:){1} ]]; then
        echo "Commande refusée."
        continue
    fi
    eval "$cmd" || true
    if [[ -f rapport.csv ]]; then
        echo "rapport.csv trouvé :"; cat rapport.csv
        if head -n1 rapport.csv | grep -q ","; then
            echo "Format correct — bien joué !"
            level_success "labyrinthe"
            break
        fi
    fi
    if (( tries >= 10 )); then
        echo "Indice: sed -E 's/Name pattern/replace/' ou awk -F';' '{print \$1","\$2","\$3}'"
    fi
done