```bash
#!/usr/bin/env bash
# Niveau: labyrinthe
# Objectif: utiliser find/xargs pour collecter fragments et recomposer un message
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

mkdir -p labyrinth/fragments
# créer fragments nommés 01..06
for i in {01..06}; do
    echo -n "" > labyrinth/fragments/frag$i
done

echo "PAD" > labyrinth/fragments/frag01
echo "-" > labyrinth/fragments/frag02
echo "BASH" > labyrinth/fragments/frag03
echo "-" > labyrinth/fragments/frag04
echo "IS" > labyrinth/fragments/frag05
echo "-AWESOME" > labyrinth/fragments/frag06

cat <<'TASK'

NIVEAU 5 — labyrinthe
Rassemble les fragments trouvés dans 'labyrinth/fragments' dans l'ordre numérique et écris le résultat dans 'message.txt'. Utilise 'find' et 'xargs' ou une boucle.

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
    # Exécuter
    eval "$cmd" || true

    if [[ -f message.txt ]]; then
        cat message.txt
        if grep -q "PAD-BASH" message.txt || grep -q "PAD-BASH-IS-AWESOME" message.txt; then
            echo "Message recomposé — Pad Bash reprend espoir !"
            level_success "chateau"
            break
        fi
    fi
    if (( tries >= 12 )); then
        echo "Indice: 'find labyrinth/fragments -type f | sort | xargs cat > message.txt'"
    fi
done
```

---