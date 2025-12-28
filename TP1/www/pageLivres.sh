#!/bin/bash

# Modèle HTML
TEMPLATE_START='<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
      rel="stylesheet"
    />
    <script type="importmap">
      {
        "imports": {
          "@material/web/": "https://esm.run/@material/web/"
        }
      }
    </script>
    <script type="module">
      import "@material/web/all.js";
      import { styles as typescaleStyles } from "@material/web/typography/md-typescale-styles.js";

      document.adoptedStyleSheets.push(typescaleStyles.styleSheet);
    </script>

    <title>Tableau des Livres</title>
  </head>
  <body>
    <h1>Tableau des Livres</h1>
    <table border="1">
      <tr>
        <th>TITRE</th>
        <th>AUTEUR</th>
        <th>EDITION</th>
        <th>PARUTION</th>
        <th>ISBN</th>
        <th>LIEN</th>
      </tr>'
TEMPLATE_END='
    </table>
  </body>
</html>'

# Contenu des lignes de tableau
CONTENU=''

# Lire le fichier CSV et accumuler les lignes de tableau
IFS='|'
while read -r AUTEUR TITRE EDITION PARUTION ISBN COUVERTURE; do
    # Ignorer la première ligne (en-têtes)
    if [[ "$AUTEUR" == "Auteur" ]]; then
        continue
    fi

    # Créer le futur lien vers le fichier HTML
    LIEN="books/$(echo "$TITRE" | tr ' ' '_' | tr -d "'").html"

    # Ajouter une ligne au tableau
    CONTENU+="
      <tr>
        <td>$TITRE</td>
        <td>$AUTEUR</td>
        <td>$EDITION</td>
        <td>$PARUTION</td>
        <td>$ISBN</td>
        <td><a href="$LIEN">Voir plus</a></td>
      </tr>"
done < "livres.csv"

# Générer le fichier HTML complet
HTML_CONTENT="$TEMPLATE_START$CONTENU$TEMPLATE_END"

# Écrire le contenu HTML dans le fichier de sortie
OUTPUT_HTML="books.html"
echo "$HTML_CONTENT" > "$OUTPUT_HTML"

echo "Le fichier HTML a été généré : $OUTPUT_HTML"
