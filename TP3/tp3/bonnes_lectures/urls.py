from django.urls import path
from . import views

urlpatterns = [
  path("", views.index, name="index"), # Base route "/"
  path("about/", views.about, name="about"), # route with just an HTTP response "/about"
  path("welcome/", views.welcome, name="welcome"), # route with the template "welcome.html" "/welcome"
  path("books/<int:book_id>", views.books, name="book"), # route with the template "books.html" "/books/<book_id>"
  path("new_book", views.new_book, name="new_book"), # route with the template "book_form.html" "/new_book"
  path("delete_book/<int:book_id>", views.delete_book, name="delete_book"), # route with the template "delete_book.html" "/delete_book/<book_id>"
  path("edit_book/<int:book_id>", views.edit_book, name="edit_book") # route which as also the template "book_form.html" "/edit_book/<book_id>"
]
