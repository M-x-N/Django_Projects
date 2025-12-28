# TP4 Framework Web

## Le TP4 se fait dans le même projet que le TP3
***Donc le nom du projet est toujours tp3***

### Question 1

- **Création d'un fichier templates/bonnes_lectures/books.html**
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bonnes Lectures</title>
</head>
<body>
  <h1>{{ book.title }}</h1>
  <p>{{ book.backCover }}</p>
</body>
</html>
```

- **Dans le fichier bonnes_lectures/views.py**
```python
def books(request, book_id): # Ajout de la liste des livres pour le TP4
  book = Book.objects.get(pk=book_id)
  return render(request, "bonnes_lectures/books.html", {"book": book})
```

- **Dans le fichier bonnes_lectures/urls.py**
```python
path('books/<int:book_id>/', views.books, name='books'),
```

### Question 2

- **Modification du fichier bonnes_lectures/models.py** _(Pour ajouter les auteurs)_
```python
from django.db import models

# Create your models here.
class Book(models.Model):
  title = models.CharField(max_length=100)
  author = models.CharField(max_length=100, default="Aucun") # Ajout du param default car on ajoute ceci sachant que la bdd à déjà des livres sans auteur
  publisher = models.CharField(max_length=100)
  year = models.DateField()
  isbn = models.CharField(max_length=100)
  backCover = models.TextField()
  cover = models.BooleanField()

  def __str__(self):
    return self.title
```

- `python manage.py makemigrations`
- `python manage.py migrate`

- **Le fichier bonnes_lectures/views.py à déjà la méthode index** _(Car question 14 du TP3 -> optionnelle)_

- **Modification de templates/bonnes_lectures/index.html** _(Pour afficher les urls vers les livres)_
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bonnes Lectures</title>
</head>
<body>
  <h1>Bonnes Lectures</h1>
  <ul>
    {% for book in all_book %}
      <li><b>{{ book.author }} </b><a href={% url 'book' book.id %}>{{ book.title }}</a></li>
    {% endfor %}
  </ul>
</body>
</html>
```

### Question 3

- **Création d'un fichier bonnes_lectures/forms.py**
```python
from django.forms import ModelForm
from bonnes_lectures.models import Book

class BookForm(ModelForm):
  class Meta:
    model = Book
    fields = ["title", "author", "publisher", "year", "backCover"]
    labels = {
      "title": "Titre",
      "author": "Auteur",
      "publisher" : "Maison d'édition",
      "year": "Année de Parution",
      "isbn": "ISBN",
      "backCover": "4ème de Couverture",
    }
```

- **Création d'un template templates/bonnes_lectures/book_form.html**
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bonnes Lectures</title>
</head>
<body>
  <form action="/new_book">
    {% crsf_token %}
    {% form %}
    <input type="submit" value="Nouveau Livre">
  </form>

</body>
</html>
```

- **Modification du fichier bonnes_lectures/views.py**
```python
from bonnes_lectures.forms import BookForm # Ajout de l'import

def new_book(request):
  if request.method == "POST":
    form = BookForm(request.POST)
    if form.is_valid():
      book = form.save(commit=False) # Pas de sauvegarde en BDD
      book.cover = 0
      book.save() # Sauvegarde en BDD
      return HttpResponseRedirect(f"/books/{book.id}") # Important de mettre le return la sinon la redirection ne se fait pas
  else:
    form = BookForm() # Formulaire vide
  return render(request, "bonnes_lectures/book_form.html", {"form": form})
```

- **Modification du fichier bonnes_lectures/urls.py**
```python
 path("new_book", views.new_book, name="new_book")
```

### Question 4 [Optionnelle]


### Question 5

- **Création du fichier bonnes_lectures/templates/bonnes_lectures/delete_book**
```html
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
</head>

<body>
    <h1>Voulez-vous vraiment effacer le livre "{{ book.title }}" ?</h1>
    <ul>
        <li><b>Auteur : </b>{{ book.author }}</li>
        <li><b>Date de publication : </b>{{ book.year }}</li>
        <li><b>book : </b>{{ book.backCover }}</li>
    </ul>
    <form method="post">
        {% csrf_token %}
        <button type="submit" name="delete">Effacer</button>
    </form>
    <p><a href={% url "index" %}>Retour aux livres</a></p>
</body>

</html>
```

- **Modification du fichier bonnes_lectures/urls.py**
```python
path("delete_book/<int:book_id>", views.delete_book, name="delete_book"),
```

- **Modification du fichier bonnes_lectures/views.py**
```python
def delete_book(request, book_id):
    book = get_object_or_404(Book, pk=book_id)
    if request.method == "POST":
        book.delete()
        return redirect("index")

    return render(request, "bonnes_lectures/delete_book.html", {"book": book})
```

### Question 6

- **Modification du fichier bonnes_lectures/views.py**
```python
def edit_book(request, book_id):
    book = get_object_or_404(Book, pk=book_id)
    if request.method == "POST":
        form = BookForm(request.POST, instance=book)
        if form.is_valid():
          book = form.save(commit=False)
          book.save()
          id = book.id
        return redirect("book", book_id=id)
    else:
        form = BookForm(instance=book)
    return render(
        request,
        "bonnes_lectures/book_form.html",
        {"form": form, "button_label": "Modifier"},
    )
```
- **Modification du fichier bonnes_lectures/urls.py**
```python
path("edit_book/<int:book_id>", views.edit_book, name="edit_book")
```
