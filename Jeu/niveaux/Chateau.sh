
```bash
#!/usr/bin/env bash
# Niveau: chateau
# Objectif: récupérer une 'réponse réseau' simulée via curl ou echo (pas d'internet requis)
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

# Simuler un petit server local par fichier
echo "{\"message\": \"Bienvenue au château\"}" > chateau_service.json

cat <<'TASK'

NIVEAU 6 — chateau
Pad Bash a besoin d'une réponse structurée JSON. Récupère le fichier 'chateau_service.json' et extrait la valeur de 'message' (sans outils externes JSON si possible).
Écris la valeur extraite dans 'response.txt'.

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

    if [[ -f response.txt ]]; then
        echo "response.txt :"; cat response.txt
        if grep -q "Bienvenue au château" response.txt; then
            echo "Très bien — tu as obtenu la réponse du château."
            level_success "finale"
            break
        fi
    fi
    if (( tries >= 10 )); then
        echo "Indice: utilises 'cat chateau_service.json | sed -E 's/.*\"message\"\s*:\s*\"([^\"]+)\".*/\1/' > response.txt'"
    fi
done