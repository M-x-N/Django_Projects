#!/bin/bash

# Lire le fichier CSV et organiser les livres par auteur
declare -A auteurs

IFS='|'

while read -r AUTEUR TITRE EDITION PARUTION ISBN COUVERTURE; do
    if [[ "$AUTEUR" == "Auteur" ]]; then
        continue
    fi

    # Créer le futur lien vers le fichier HTML du livre
    LIEN="../books/$(echo "$TITRE" | tr ' ' '_' | tr -d "'").html"

    # Ajouter le livre à l'auteur correspondant
    auteurs["$AUTEUR"]+="$TITRE"
done < "livres.csv"

# Générer les pages HTML pour chaque auteur
for auteur in "${!auteurs[@]}"; do
    CONTENU_AUTEUR="<h1>Livres de $auteur</h1><ul>"
    IFS='|' read -ra livres <<< "${auteurs[$auteur]}"
    for livre in "${livres[@]}"; do
        IFS='|' read -r TITRE LIEN <<< "$livre"
        CONTENU_AUTEUR+="<li><a href=\"$LIEN\">$TITRE</a></li>"
    done
    CONTENU_AUTEUR+="</ul>"

    # Écrire le contenu HTML dans le fichier de sortie de l'auteur
    OUTPUT_HTML="authors/$(echo "$auteur" | tr ' ' '_' | tr -d "'").html"
    echo "$CONTENU_AUTEUR" > "$OUTPUT_HTML"
done

# Générer la page principale listant tous les auteurs
CONTENU_PRINCIPAL="<h1>Liste des auteurs</h1><ul>"
for auteur in "${!auteurs[@]}"; do
    LIEN_AUTEUR="authors/$(echo "$auteur" | tr ' ' '_' | tr -d "'").html"
    CONTENU_PRINCIPAL+="<li><a href="$LIEN_AUTEUR">$auteur</a></li>"
done
CONTENU_PRINCIPAL+="</ul>"

# Écrire le contenu HTML dans le fichier de sortie principal
OUTPUT_HTML_PRINCIPAL="auteurs.html"
echo "$CONTENU_PRINCIPAL" > "$OUTPUT_HTML_PRINCIPAL"

echo "Les fichiers HTML des auteurs ont été générés."
