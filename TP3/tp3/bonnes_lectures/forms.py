from django.forms import ModelForm
from bonnes_lectures.models import Book

# Form to make a book
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
