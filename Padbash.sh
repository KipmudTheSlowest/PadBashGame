#!/bin/bash

# --- Configuration des Couleurs ---
R='\033[0;31m' # Rouge
G='\033[0;32m' # Vert
B='\033[0;34m' # Bleu
Y='\033[1;33m' # Jaune
C='\033[0;36m' # Cyan
NC='\033[0m'   # Pas de couleur

# --- Fonction de Nettoyage et Création ---
echo -e "${Y}Création du Royaume Bash pour Pad Bash...${NC}"

# On nettoie une éventuelle installation précédente
rm -rf RoyaumeBash
mkdir -p RoyaumeBash/Hub

# Chemin de base
BASE_DIR=$(pwd)/RoyaumeBash

# --- ================================= ---
# --- NIVEAU 1 : L'INTRODUCTION         ---
# --- Thème : ls, cd, cat               ---
# --- ================================= ---
mkdir -p "${BASE_DIR}/Introduction/foret_sombre"

# Fichier d'histoire
cat << 'EOF' > "${BASE_DIR}/Introduction/lisezmoi.txt"
Bienvenue, courageux aventurier !

Je suis Pad Bash, une IA experte en commandes... enfin, je l'étais.
La maléfique Fée Oublibash m'a jeté un sort ! J'ai tout oublié !

Je suis perdu dans cette 'Introduction'. Je ne sais même plus comment
'regarder' autour de moi ou 'lire' des panneaux.

La Fée a ri et m'a dit : "Tu ne trouveras jamais la 'clairiere' !"

AIDEZ-MOI !
1. 'Regardez'  ce qu'il y a dans ce dossier.
2. 'Changez de dossier'  pour aller dans la 'foret_sombre'.
3. 'Lisez' le message qui s'y trouve.
4. Une fois que vous avez lu le message, revenez ici
   et lancez le script './sortir.sh' pour me libérer !
EOF

# Fichier caché dans le niveau
cat << 'EOF' > "${BASE_DIR}/Introduction/foret_sombre/message.txt"
Vous l'avez trouvé ! Pad Bash se souvient de 'ls' et 'cd' !
EOF

# Script de validation du Niveau 1
cat << 'EOF' > "${BASE_DIR}/Introduction/sortir.sh"
#!/bin/bash
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
NC='\033[0m'

echo -e "${Y}Vérification...${NC}"
sleep 1

if [ -f "foret_sombre/message.txt" ]; then
    echo -e "${G}BRAVO !${NC} Pad Bash se souvient de 'ls', 'cd' et 'cat' !"
    echo -e "Fée Oublibash (au loin): ${R}'NON ! Mon sort s'affaiblit !'${NC}"
    echo ""
    echo -e "${Y}--- NIVEAU 2 DÉVERROUILLÉ : Creation ---${NC}"
    echo "Un nouvel atelier est apparu dans le Hub. Allez-y !"
    
    # --- Création dynamique du Niveau 2 ---
    mkdir -p ../Creation/atelier
    
    cat << 'EON2' > ../Creation/lisezmoi.txt
Pad Bash: "Oh non ! La Fée a volé tous mes outils ! Cet 'atelier' est vide !"

"Elle a dit que je ne savais plus 'créer' un fichier,
ni 'créer un dossier', ni 'copier' !"

Aidez-moi ! Dans le dossier 'atelier' :
1. 'Créez un fichier' nommé 'marteau'.
2. 'Créez un dossier' nommé 'caisse_a_outils' .
3. 'Copiez' le 'marteau' DANS la 'caisse_a_outils'.

Quand c'est fait, lancez './construire.sh' depuis le dossier 'Creation'.
EON2

    cat << 'EON2V' > ../Creation/construire.sh
#!/bin/bash
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
NC='\033[0m'
if [ -f "atelier/marteau" ] && [ -d "atelier/caisse_a_outils" ] && [ -f "atelier/caisse_a_outils/marteau" ]; then
    echo -e "${G}FANTASTIQUE !${NC} Pad Bash peut à nouveau construire !"
    echo -e "Fée Oublibash: ${R}'Mes plans sont ruinés ! Mais il ne trouvera jamais mon mot de passe !'${NC}"
    echo -e "${Y}--- NIVEAU 3 DÉVERROUILLÉ : Recherche ---${NC}"

    # --- Création dynamique du Niveau 3 ---
    mkdir -p ../Recherche/labyrinthe/de/fichiers/tres/profonds
    echo "Fichier de log... blabla... erreur..." > ../Recherche/labyrinthe/de/fichiers/journal.log
    echo "Une simple note." > ../Recherche/labyrinthe/de/fichiers/tres/note.txt
    echo "Le mot de passe secret est : 'SESAME'" > ../Recherche/labyrinthe/de/fichiers/tres/profonds/secret.txt
    
    cat << 'EON3' > ../Recherche/lisezmoi.txt
Pad Bash: "La Fée Oublibash a caché un mot de passe dans un 'labyrinthe' de dossiers.
Je dois 'trouver'  le fichier 'secret.txt'.
Puis je dois 'chercher'  le mot de passe qui s'y cache."

1. Utilisez 'find' pour localiser 'secret.txt' dans le 'labyrinthe'.
   
2. Lisez le fichier pour trouver le mot de passe.
   

Lancez './chercher.sh' et donnez-lui le mot de passe !
EON3

    cat << 'EON3V' > ../Recherche/chercher.sh
#!/bin/bash
G='\033[0;32m'
Y='\033[1;33m'
R='\033[0;31m'
NC='\033[0m'
read -p "Quel est le mot de passe secret ? " mdp
if [ "$mdp" == "SESAME" ]; then
    echo -e "${G}INCROYABLE !${NC} Pad Bash se souvient de 'find' et 'grep' !"
    echo -e "Fée Oublibash: ${R}'Il est malin... mais il n'osera jamais toucher à mon coffre !'${NC}"
    echo -e "${Y}--- NIVEAU 4 DÉVERROUILLÉ : Permissions ---${NC}"

    # --- Création dynamique du Niveau 4 ---
    mkdir -p ../Permissions
    echo "Ce fichier est illisible !" > ../Permissions/coffre.txt
    # On bloque les permissions SEULEMENT du coffre pour l'instant
    chmod 000 ../Permissions/coffre.txt

    cat << 'EON4' > ../Permissions/lisezmoi.txt
Pad Bash: "La Fée a scellé ce 'coffre.txt' et cassé la 'clef.sh' !
Je ne peux ni 'lire' le coffre, ni 'exécuter'  la clef.
Elle a dû jouer avec les 'permissions' !"

1. Donnez-vous la 'permission de lire' le 'coffre.txt'.
   
2. Donnez-vous la 'permission d'exécuter'  la 'clef.sh'.


Quand c'est fait, lancez './deverrouiller.sh' !
EON4

    # On crée le VRAI script clef.sh et on le bloque
    echo '#!/bin/bash' > ../Permissions/clef.sh
    echo 'echo "La clef fonctionne !"' >> ../Permissions/clef.sh
    chmod 000 ../Permissions/clef.sh
    
    cat << 'EON4V' > ../Permissions/deverrouiller.sh
#!/bin/bash
G='\033[0;32m'
Y='\033[1;33m'
R='\033[0;31m'
NC='\033[0m'
if [ -r "coffre.txt" ] && [ -x "clef.sh" ]; then
    echo -e "${G}Le coffre s'ouvre ! La clef tourne !${NC}"
    echo -e "Fée Oublibash: ${R}'Il a 'chmod' ! Grrr ! Mais ses 'pipes' sont rouillés !'${NC}"
    echo -e "${Y}--- NIVEAU 5 DÉVERROUILLÉ : Filtre ---${NC}"

    # --- Création dynamique du Niveau 5 ---
    mkdir -p ../Filtre
    echo "La Fée-STOP-Oublibash a-STOP-corrompu ce-STOP-message. Le-STOP-sort est-STOP-'MAGIE'-STOP-." > ../Filtre/message_corrompu.txt

    cat << 'EON5' > ../Filtre/lisezmoi.txt
Pad Bash: "Ce 'message_corrompu.txt' est illisible !
La Fée a inséré le mot '-STOP-' partout !
Je dois 'lire' le message, le 'tuyauter' vers un
outil de 'substitution' pour enlever tous les '-STOP-'."


Lancez './purifier.sh' et donnez-lui le sort purifié !
EON5

    cat << 'EON5V' > ../Filtre/purifier.sh
#!/bin/bash
G='\033[0;32m'
Y='\033[1;33m'
R='\033[0;31m'
NC='\033[0m'
read -p "Quel est le sort purifié (entre guillemets) ? " sort
if [ "$sort" == "'MAGIE'" ]; then
    echo -e "${G}Le filtre a fonctionné !${NC} Pad Bash se souvient des 'pipes' et de 'sed' !"
    echo -e "Fée Oublibash: ${R}'C'est la fin... mais il ne survivra pas à mon armée !'${NC}"
    echo -e "${Y}--- NIVEAU FINAL : Boss ---${NC}"

    # --- Création dynamique du Niveau 6 ---
    mkdir -p ../Boss/armee
    touch ../Boss/armee/lutin{1..5}.txt
    
    cat << 'EON6' > ../Boss/lisezmoi.txt
Pad Bash: "LE COMBAT FINAL ! La Fée a invoqué une 'armee' de 5 'lutins' (.txt) !"
"Je dois tous les 'renommer' (mv) en '.capture' pour les vaincre.
Mais le faire un par un est trop long... Je dois 'automatiser' (for loop) !"

1. Allez dans le dossier 'armee'.
2. Utilisez une 'boucle for' pour renommer tous les '.txt' en '.capture'.
3. Revenez ici et lancez './combat.sh' !
EON6

    cat << 'EON6V' > ../Boss/combat.sh
#!/bin/bash
G='\033[0;32m'
Y='\033[1;33m'
R='\033[0;31m'
C='\033[0;36m'
NC='\033[0m'
count=$(ls -1 armee/*.capture 2>/dev/null | wc -l)
if [ $count -eq 5 ]; then
    echo -e "${G}VICTOIRE TOTALE !${NC}"
    echo -e "${C}Pad Bash:${NC} 'J'ai retrouvé toute ma mémoire BASH ! Merci, aventurier !'"
    echo -e "${R}Fée Oublibash:${NC} 'NOOOOON ! Je reviendrai !'"
    echo ""
    echo -e "${Y}**********************************${NC}"
    echo -e "${Y}*** VOUS AVEZ GAGNÉ LE JEU !  ***${NC}"
    echo -e "${Y}**********************************${NC}"
else
    echo -e "${R}L'armée de la Fée est toujours là...${NC}"
    echo "Il manque des captures dans le dossier 'armee'."
    echo "(Vérifiez que les 5 fichiers .txt sont devenus .capture)"
fi
chmod +x ../Boss/combat.sh
EON6V
else
    echo -e "${R}Le sort n'est pas le bon...${NC}"
    echo "(N'oubliez pas les guillemets simples autour du code)"
fi
chmod +x ../Filtre/purifier.sh
EON5V
else
    echo -e "${R}Le coffre est toujours scellé ou la clef est cassée.${NC}"
fi
chmod +x ../Permissions/deverrouiller.sh
EON4V
else
    echo -e "${R}Ce n'est pas le bon mot de passe...${NC} Essayez encore !"
fi
chmod +x ../Recherche/chercher.sh
EON3V
else
    echo -e "${R}L'atelier n'est pas complet.${NC}"
    echo "Vérifiez que 'marteau' existe, que 'caisse_a_outils' existe,"
    echo "et que 'marteau' a bien été copié DEDANS."
fi
chmod +x ../Creation/construire.sh
EON2V
else
    echo -e "${R}Erreur...${NC} Le niveau semble corrompu. Réinstallez le jeu."
fi
EOF

# --- Finalisation de l'installation ---
chmod +x "${BASE_DIR}/Introduction/sortir.sh"

echo -e "\n${G}Le jeu 'Pad Bash vs Fée Oublibash' est installé (V3 Corrigée) !${NC}"
echo -e "Pour commencer l'aventure, tapez :"
echo -e "\n${C}cd RoyaumeBash/Introduction${NC}"
echo -e "\n...et ${Y}lisez le premier parchemin${NC} avec :"
