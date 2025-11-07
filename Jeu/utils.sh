```bash
#!/usr/bin/env bash
# Fonctions utilitaires pour PadBash
set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SAVE_DIR="$ROOT/save"
ASSETS="$ROOT/assets"
NIVEAUX="$ROOT/niveaux"

function welcome_banner() {
    clear
    cat <<'BANNER'

██████╗  █████╗ ██████╗  █████╗  ██████╗  █████╗ ███████╗
██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔════╝
██████╔╝███████║██████╔╝███████║██║  ███╗███████║███████╗
██╔══██╗██╔══██║██╔══██╗██╔══██║██║   ██║██╔══██║╚════██║
██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝██║  ██║███████║
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

Pad Bash — Aidez Pad à retrouver les commandes Bash !
BANNER
}

function player_create() {
    echo -n "Entrez votre pseudo > "
    read -r PSEUDO
    echo "$PSEUDO" > "$SAVE_DIR/player_name"
    echo "accueil" > "$SAVE_DIR/current_level"
    echo "0" > "$SAVE_DIR/score"
    echo "Partie créée pour $PSEUDO"
}

function player_load() {
    if [[ -f "$SAVE_DIR/player_name" ]]; then
        echo "Joueur: $(cat "$SAVE_DIR/player_name")"
        return 0
    else
        echo "Aucune partie trouvée. Créez-en une nouvelle."
        return 1
    fi
}

function save_progress() {
    local lvl="$1"
    echo "$lvl" > "$SAVE_DIR/current_level"
}

function add_score() {
    local add="$1"
    local cur=0
    if [[ -f "$SAVE_DIR/score" ]]; then cur=$(cat "$SAVE_DIR/score"); fi
    echo $((cur + add)) > "$SAVE_DIR/score"
}

function run_level() {
    local level_name="$1"
    local level_script="$NIVEAUX/$level_name"
    if [[ -x "$level_script" ]]; then
        echo
        echo "--- Lancement du niveau: $level_name ---"
        "$level_script"
    else
        echo "Niveau introuvable ou non exécutable: $level_name"
    fi
}

function level_success() {
    local next_level="$1"
    echo
    echo "🎉 Niveau réussi ! Pad Bash récupère un souvenir..."
    save_progress "$next_level"
    add_score 100
    echo "Prochain niveau: $next_level"
}

function level_fail() {
    echo
    echo "💥 Échec. Réessaye ou consulte un indice (menu principal -> Indices)."
}

function prompt_command_capture() {
    # Affiche un prompt coloré pour saisir une commande
    echo -n -e "\e[1;32mPadBash$ \e[0m"
    read -r USER_CMD
    echo "$USER_CMD"
}
```

---