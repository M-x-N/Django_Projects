from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse, HttpResponseRedirect

from bonnes_lectures.models import *
from bonnes_lectures.forms import BookForm

# About page "/about"
def about(request):
  return HttpResponse("Application Bonnes Lectures, développée en TP de Framework Web, Université d’Orléans, 2024")

# Welcome page "/welcome"
def welcome(request):
  return render(request, "bonnes_lectures/welcome.html")

# index page "/"
def index(request):
  books = Book.objects.order_by("year")
  context = { "all_book" : books } # Liens template <-> vue
  return render (request , "bonnes_lectures/index.html", context)

# books page "/books/<books_id>"
def books(request, book_id): # Ajout de la liste des livres pour le TP4
  book = Book.objects.get(pk=book_id)
  return render(request, "bonnes_lectures/books.html", {"book": book})

# make a new book page "/new_book"
def new_book(request):
  if request.method == "POST":
    form = BookForm(request.POST)
    if form.is_valid():
      book = form.save(commit=False) # Pas de sauvegarde en BDD
      book.cover = 0
      book.save() # Sauvegarde en BDD
      return HttpResponseRedirect(f"/books/{book.id}")
  else:
    form = BookForm() # Formulaire vide
  return render(request, "bonnes_lectures/book_form.html", {"form": form})

# delete a book page "/delete_book/<book_id>"
def delete_book(request, book_id):
    book = get_object_or_404(Book, pk=book_id)
    if request.method == "POST":
        book.delete()
        return redirect("index")

    return render(request, "bonnes_lectures/delete_book.html", {"book": book})

# make modification on a book page "/edit_book/<book_id>"
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
