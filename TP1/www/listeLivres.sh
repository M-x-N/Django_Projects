#!/bin/bash

# Séparation des colonnes
IFS='|'

# Lire le fichier CSV ligne par ligne
while read -r AUTEUR TITRE EDITION PARUTION ISBN COUVERTURE; do
    # Charger le modèle HTML
    modele=$(cat "ListeLivresModel.html")

    # Remplacer les variables de modèle par les valeurs du CSV
    modele=$(echo "$modele" | sed "s/%AUTEUR%/$AUTEUR/")
    modele=$(echo "$modele" | sed "s/%TITRE%/$TITRE/")
    modele=$(echo "$modele" | sed "s/%EDITION%/$EDITION/")
    modele=$(echo "$modele" | sed "s/%PARUTION%/$PARUTION/")
    modele=$(echo "$modele" | sed "s/%ISBN%/$ISBN/")
    modele=$(echo "$modele" | sed "s/%COUVERTURE%/$COUVERTURE/")

    # Créer un nom de fichier basé sur le titre du livre
    fichier_html="books/$(echo "$TITRE" | tr ' ' '_' | tr -d "'").html"

    # Sauvegarder le contenu modifié dans un nouveau fichier HTML
    echo "$modele" > "$fichier_html"

    # Afficher le nom du fichier créé
    echo "Créé: $fichier_html"

done < "livres.csv"
