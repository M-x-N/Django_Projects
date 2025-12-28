from django.db import models

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
