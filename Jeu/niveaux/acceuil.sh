```bash
#!/usr/bin/env bash
# Niveau: accueil
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

cat <<'INTRO'

NIVEAU 1 — accueil
Pad Bash ne se souvient que des bases. Il te demande d'afficher le contenu d'un fichier secret nommé '.memoire' situé dans ce dossier.
Tu peux exécuter une commande sur l'invite. Tape la commande qui affiche le fichier.

INTRO

# créer le fichier secret
echo "Je suis Pad Bash. Souviens-toi: ls, cat, echo..." > .memoire

tries=0
while true; do
    echo
    cmd=$(prompt_command_capture)
    tries=$((tries+1))
    # sécurité minimale: n'autorise pas commandes dangereuses (rm, mv hors scope, reboot)
    if [[ "$cmd" =~ ^(rm|reboot|shutdown|sudo|dd|:){1} ]]; then
        echo "Commande refusée par la fée Oublibash (trop dangereuse)."
        continue
    fi
    # Exécuter commande dans sous-shell limité (dans ce dossier)
    eval "$cmd"
    # vérifier si sortie contient le texte attendu
    if grep -q "Pad Bash" .memoire 2>/dev/null; then
        echo "Bravo — tu as trouvé la mémoire de Pad Bash !"
        level_success "foret"
        break
    else
        echo "Ça ne semble pas être la bonne commande. Essaie autre chose."
    fi
    if (( tries >= 6 )); then
        echo "Tu peux regarder un indice via le menu principal (Indices)."
    fi
done
```

---