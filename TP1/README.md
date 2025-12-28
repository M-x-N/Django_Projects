# Suivis des commandes du TP

## Question 1

- mkdir www
- cd www
- mkdir authors books images

## Question 2

- cd www
- touch index.html

```html
index.html:
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bibliothèque</title>
  </head>
  <body>
    <nav>
      <ul>
        <li><a href="livres.html">Livres</a></li>
        <li><a href="auteurs.html">Auteurs</a></li>
        <li><a href="books/freakonomics.html">Freakonomics</a></li>
      </ul>
    </nav>
    <h1>Bienvenue à la Bibliothèque</h1>
    <p>
      Ce site contient des fiches de livres. Vous pouvez sélectionner les livres
      par une liste de livres ou par une liste d'auteurs.
    </p>
    <h4>Auteur du site : Maximilien</h4>
  </body>
</html>
```

## Question 3

- touch books/freakonomics.html

```html
freakonomics.html:
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Détail du Livre</title>
  </head>
  <body>
    <nav>
      <ul>
        <li><a href="../index.html">Accueil</a></li>
      </ul>
    </nav>
    <h1>Titre du Livre: Freakonomics</h1>
    <p><strong>Auteur:</strong> Stephen J. Dubner et Steven D. Levitt</p>
    <p><strong>Maison d'édition:</strong> Folio</p>
    <p><strong>Année de parution:</strong> 2007</p>
    <p><strong>ISBN:</strong> 978-2070341795</p>
    <h2>Quatrième de couverture</h2>
    <p>
      Quel lien entre la législation de l'avortement et la baisse de la
      criminalité aux États-Unis ? Quelles sont les vraies motivations des
      agents immobiliers ? Pourquoi les revendeurs de drogue vivent-ils plus
      longtemps chez leur mère ? L'économie, vue sous cet angle, incongru en
      apparence, mais qui est celui de la plus sérieuse rationalité des agents,
      des comportements, des causes et effets, traite de sujets peu
      conventionnels. Elle a reçu un nom : freakonomics, ou " économie saugrenue
      ". Elle jette une lumière de biais sur le désordre des événements ; elle
      met à nu des a priori à prétention de scientificité irréfutable ; elle
      transforme notre regard sur le monde globalisé, qui nous apparaît, pour
      finir, moins impénétrable et incompréhensible.
    </p>
  </body>
</html>
```

## Question 4

- touch books/modeleLivre.html

```html
modeleLivre.html:
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Détail du Livre</title>
  </head>
  <body>
    <nav>
      <ul>
        <li><a href="../index.html">Accueil</a></li>
        <li><a href="../livres.html">Livres</a></li>
        <li><a href="../auteurs.html">Auteurs</a></li>
      </ul>
    </nav>
    <h1>Titre du Livre: %TITRE%</h1>
    <p><strong>Auteur:</strong> %AUTEUR%</p>
    <p><strong>Maison d'édition:</strong> %EDITION%</p>
    <p><strong>Année de parution:</strong> %PARUTION%</p>
    <p><strong>ISBN:</strong> %ISBN%</p>
    <h2>Quatrième de couverture</h2>
    <p>%COUVERTURE%</p>
  </body>
</html>
```

## Question 5

- touch ListeLivresModel.html

```html
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Détail du Livre</title>
  </head>
  <body>
    <nav>
      <ul>
        <li><a href="../index.html">Accueil</a></li>
      </ul>
    </nav>
    <h1>Titre du Livre: %TITRE%</h1>
    <p><strong>Auteur:</strong> %AUTEUR%</p>
    <p><strong>Maison d'édition:</strong> %EDITION%</p>
    <p><strong>Année de parution:</strong> %PARUTION%</p>
    <p><strong>ISBN:</strong> %ISBN%</p>
    <h2>Quatrième de couverture :</h2>
    <p>%COUVERTURE%</p>
  </body>
  <footer>
    <a href="../index.html">Retour à l'accueil</a>
  </footer>
</html>
```

- touch listeLivres.sh

```bash
#!/bin/bash

# Séparation des colonnes
IFS='|'

# Lire le fichier CSV ligne par ligne
while read -r AUTEUR TITRE EDITION PARUTION ISBN COUVERTURE; do
    # Charger le modèle HTML
    modele=$(cat "PageLivreModel.html")

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
```

- bash listeLivres.sh

## Question 6

- touch pageLivre.sh

```bash
#!/bin/bash

# Modèle HTML
TEMPLATE_START='<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
        <th>COUVERTURE</th>
      </tr>'
TEMPLATE_END='
    </table>
  </body>
</html>'

# Contenu des lignes de tableau
CONTENU=''

# Lire le fichier CSV et accumuler les lignes de tableau
#!/bin/bash

# Modèle HTML
TEMPLATE_START='<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
        <th>COUVERTURE</th>
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
        <td>$COUVERTURE</td>
        <td><a href="$LIEN">Voir plus</a></td>
      </tr>"
done < "livres.csv"

# Générer le fichier HTML complet
HTML_CONTENT="$TEMPLATE_START$CONTENU$TEMPLATE_END"

# Écrire le contenu HTML dans le fichier de sortie
OUTPUT_HTML="books.html"
echo "$HTML_CONTENT" > "$OUTPUT_HTML"

echo "Le fichier HTML a été généré : $OUTPUT_HTML"

```

- bash pageLivres.sh

## Question 7

**_Méthode Par CDN_**

- Ajout de :

```html
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
```

au fichier modeleLivre.html et books.html

- bash listeLivres.sh

**\*Modification des Scripts bash**

- listeLivres.sh

```bash
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
```

- pageLivres.sh

```bash
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
```

## Question 8 [Optionnelle]

- touch pageLivres.sh

```bash

```
