```bash
#!/usr/bin/env bash
# Niveau: donjon
# Objectif: corriger des permissions et rediriger la sortie d'un programme
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

# Préparer fichiers
echo "Le trésor est dans coffre.txt" > coffre.txt
chmod 600 coffre.txt

echo
cat <<'TASK'

NIVEAU 3 — donjon
Le coffre est protégé par des permissions. Pad Bash ne peut pas lire 'coffre.txt' tant que les droits ne sont pas ajustés.
Objectif 1: Afficher le contenu de coffre.txt sans utiliser sudo (il faut changer les permissions pour que le fichier soit lisible).
Objectif 2: Rediriger la sortie d'une commande générant un message d'erreur vers un fichier 'logs/erreur.log' en utilisant la redirection d'erreur (2>).

TASK

mkdir -p logs
tries=0
solved_perms=0
solved_logs=0

while true; do
    echo
    cmd=$(prompt_command_capture)
    tries=$((tries+1))
    if [[ "$cmd" =~ ^(rm|reboot|shutdown|dd|:){1} ]]; then
        echo "Commande refusée."
        continue
    fi
    eval "$cmd" || true

    if [[ $solved_perms -eq 0 ]]; then
        if [[ -r coffre.txt ]]; then
            echo "Le coffre est lisible:"; cat coffre.txt
            solved_perms=1
            add_score 50
        fi
    fi

    if [[ $solved_logs -eq 0 ]]; then
        if [[ -f logs/erreur.log ]] && grep -q "commande_invalide" logs/erreur.log 2>/dev/null; then
            echo "La redirection d'erreur fonctionne — logs/erreur.log contient l'erreur."
            solved_logs=1
            add_score 50
        fi
    fi

    if [[ $solved_perms -eq 1 && $solved_logs -eq 1 ]]; then
        echo "Tu as triomphé du donjon."
        level_success "atelier"
        break
    fi

    if (( tries >= 12 )); then
        echo "Astuce: 'chmod' pour les permissions; pour rediriger une erreur: 'commande 2> logs/erreur.log'"
    fi
done