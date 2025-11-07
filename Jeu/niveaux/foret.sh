```bash
#!/usr/bin/env bash
# Niveau: foret
# Objectif: retrouver une clé cachée dans des fichiers (filtres/grep)
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIB="$ROOT/lib"
source "$LIB/utils.sh"

# Préparer l'environnement
mkdir -p cache
printf "clé: OUBLI-42\n" > cache/.cle
printf "rien ici\n" > cache/README.txt
printf "indice: chercher avec grep\n" > cache/indice.txt

cat <<'TASK'

NIVEAU 2 — foret
Pad Bash murmure: "La clef est cachée dans la forêt de fichiers. Montre-moi le contenu du fichier qui contient 'clé:'."

Instructions: utilisez des commandes pour chercher et afficher la clé.

TASK

tries=0
while true; do
    echo
    cmd=$(prompt_command_capture)
    tries=$((tries+1))
    if [[ "$cmd" =~ ^(rm|reboot|shutdown|sudo|dd|:){1} ]]; then
        echo "Commande refusée."
        continue
    fi
    eval "$cmd"
    # verifier si la sortie a la clé dans le dossier cache
    if grep -R --quiet "clé:" cache 2>/dev/null; then
        grep -R "clé:" cache
        echo "Excellent — tu as récupéré la clé !"
        level_success "donjon"
        break
    else
        echo "Rien trouvé. Essaie 'grep -R' ou 'ls -a' dans le dossier cache."
    fi
    if (( tries >= 8 )); then
        echo "Indice: pense à -R pour une recherche récursive."
    fi
done