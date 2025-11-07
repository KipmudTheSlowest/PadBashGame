```bash
#!/usr/bin/env bash
# Lanceur principal de PadBash
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")" && pwd)"
LIB="$ROOT/lib"
NIVEAUX="$ROOT/niveaux"
SAVE_DIR="$ROOT/save"
ASSETS="$ROOT/assets"

mkdir -p "$SAVE_DIR"

source "$LIB/utils.sh"

welcome_banner

while true; do
    echo
    echo "=== Menu principal — Pad Bash ==="
    echo "1) Nouvelle partie"
    echo "2) Charger une partie"
    echo "3) Tutoriel rapide"
    echo "4) Indices limités"
    echo "5) Quitter"
    echo -n "Choix > "
    read -r CHOIX
    case "$CHOIX" in
        1)
            player_create
            run_level "accueil"
            break
            ;;
        2)
            if player_load; then
                current_level_file="$SAVE_DIR/current_level"
                if [[ -f "$current_level_file" ]]; then
                    lvl=$(cat "$current_level_file")
                    echo "Chargé : niveau $lvl"
                    run_level "$lvl"
                fi
            fi
            break
            ;;
        3)
            tutorial
            ;;
        4)
            echo "Indices disponibles :"
            sed -n '1,120p' "$ASSETS/tips.txt"
            ;;
        5)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix invalide"
            ;;
    esac
done

# boucle principale après les niveaux — propose de rejouer ou quitter
while true; do
    echo
    echo "Que voulez-vous faire ?"
    echo "1) Reprendre la partie"
    echo "2) Nouvelle partie"
    echo "3) Quitter"
    read -r CHOIX2
    case "$CHOIX2" in
        1)
            if player_load; then
                lvl=$(cat "$SAVE_DIR/current_level")
                run_level "$lvl"
            fi
            ;;
        2)
            player_create
            run_level "accueil"
            ;;
        3)
            echo "Fin du jeu — merci d'avoir aidé Pad Bash !"
            exit 0
            ;;
        *) echo "Choix invalide" ;;
    esac
done