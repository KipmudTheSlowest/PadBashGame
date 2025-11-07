```bash
#!/usr/bin/env bash
# Niveau: finale (imbriqué et combinatoire)
# Objectif: résoud plusieurs sous-énigmes et produire 'liberation.txt'
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

# Sous-énigmes: 1) décoder une chaîne base64, 2) extraire ligne N d'un fichier, 3) concaténer et chiffrer (simple ROT13)

echo "U1Q6IFBBRC1CQVNILQ==" > puzzle_base64.txt
cat > lines.txt <<'L'
Zero
Un
Deux
Trois
Quatre
Cinq
L

cat > rot_input.txt <<'R'
PadBash is saved
R

cat <<'TASK'

NIVEAU FINAL
Tu dois:
1) décoder puzzle_base64.txt en clair
2) prendre la 2ème ligne (indice: 'Un' correspond à >1 selon ton système) de lines.txt
3) concaténer les résultats et appliquer un ROT13 pour produire 'liberation.txt'

Utilise les commandes que tu as apprises.

TASK

tries=0
solved=0
while true; do
    echo
    cmd=$(prompt_command_capture)
    tries=$((tries+1))
    if [[ "$cmd" =~ ^(rm|reboot|shutdown|dd|:){1} ]]; then
        echo "Commande refusée."
        continue
    fi
    eval "$cmd" || true

    if [[ -f liberation.txt ]]; then
        echo "liberation.txt :"; cat liberation.txt
        echo "Félicitations ! Vous avez libéré la mémoire de Pad Bash."
        add_score 500
        echo "===== FIN DU JEU ====="
        echo "Score final: $(cat "$SAVE_DIR/score")"
        solved=1
        break
    fi

    if (( tries >= 20 )); then
        echo "Indices:
- base64 -d
- sed -n '2p' lines.txt
- tr 'A-Za-z' 'N-Za-mn-za'
"
    fi
done

if (( solved )); then
    exit 0
else
    exit 1
fi
```

---

### save/.gitkeep