# TP3 Framework Web

## Mise en place de l'environnnement de développement

### Question 1

- `USERNAME=$(id -un) USERID=$(id -u) docker-compose up -d`

```bash
[+] Building 11.9s (14/14) FINISHED                                                                                                                                docker:orbstack
 => [base internal] load build definition from Dockerfile_tp3                                                                                                                 0.1s
 => => transferring dockerfile: 960B                                                                                                                                          0.0s
 => [base internal] load metadata for docker.io/library/alpine:3.20.3                                                                                                         1.6s
 => [base internal] load .dockerignore                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                               0.0s
 => [base 1/9] FROM docker.io/library/alpine:3.20.3@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d                                                   0.3s
 => => resolve docker.io/library/alpine:3.20.3@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d                                                        0.0s
 => => sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d 1.85kB / 1.85kB                                                                                0.0s
 => => sha256:9cee2b382fe2412cd77d5d437d15a93da8de373813621f2e4d406e3df0cf0e7c 528B / 528B                                                                                    0.0s
 => => sha256:c157a85ed455142fd79bff5dce951fd5f5b0d0c6e45e6f54cfd0c4e2bdec587b 1.49kB / 1.49kB                                                                                0.0s
 => => sha256:cf04c63912e16506c4413937c7f4579018e4bb25c272d989789cfba77b12f951 4.09MB / 4.09MB                                                                                0.2s
 => => extracting sha256:cf04c63912e16506c4413937c7f4579018e4bb25c272d989789cfba77b12f951                                                                                     0.1s
 => [base 2/9] RUN echo "==============================="                                                                                                                     0.2s
 => [base 3/9] RUN echo "mxn (501)"                                                                                                                                           0.1s
 => [base 4/9] RUN echo "==============================="                                                                                                                     0.1s
 => [base 5/9] RUN apk update &&     apk add --no-cache         python3=~3.12 sqlite=~3.45         py3-pip=~24.0 pipx=~1.6         bash shadow                                2.0s
 => [base 6/9] RUN echo "UID_MAX 9223372036854775807" > /etc/login.defs &&     /usr/sbin/useradd -m -d /home/user -s /bin/bash -u 501 mxn                                     0.1s
 => [base 7/9] RUN python -m pipx install django==5.1.1 &&     python -m pipx ensurepath &&     python -m pipx inject django tzdata                                           6.7s
 => [base 8/9] RUN echo 'export PS1="[ $(whoami) | \w ] "' >> /home/user/.bashrc &&     echo 'source ~/.local/share/pipx/venvs/django/bin/activate'         >> /home/user/.b  0.1s
 => [base 9/9] WORKDIR /home/user/workspace                                                                                                                                   0.0s
 => [base] exporting to image                                                                                                                                                 0.4s
 => => exporting layers                                                                                                                                                       0.4s
 => => writing image sha256:2589f97447cff2581679d982796f46273aace93016e772205e45ae3f0552c5bb                                                                                  0.0s
 => => naming to docker.io/library/tp3-base                                                                                                                                   0.0s
 => [base] resolving provenance for metadata file                                                                                                                             0.0s
[+] Running 2/2
 ✔ Network tp3_default    Created                                                                                                                                             0.0s
 ✔ Container fw1-tp3-mxn  Started
```

- `docker exec -ti fw1-tp3-mxn whoami` _(commande de test -> retourne mxn)_

### Question 2

- `code .`
- **Installer l'extension "Remote - Containers"** _(Si non installé précédemment)_
- **Ouvrir l'explorateur distant de VSCode**
- **Cliquez sur la ➡️**
- **Ouvrir le dossier _/home/user/workspage_**

### Question 3

- **Cmd + J _(Ouvrir un terminal)_**

### Question 4

**_Cette commande permet la création d'un projet Django_**

- `django-admin startproject tp3`

### Question 5

- **cd tp3**
- `python manage.py runserver 0.0.0.0:8000 &` _(Le port 8000 du container est déjà mappé au port 8080 pour le système hôte)_
- **Ouvrir un navigateur web -> <http://localhost:8080> pour voir le site**

### Question 6

- `python manage.py startapp bonnes_lectures`

- **Dans le fichier /workspace/tp3/tp3/settings.py**

```python
INSTALLED_APPS = [
[+] 'bonnes_lectures.apps.BonnesLecturesConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

### Question 7

- **Installer python dans le container via VSCode**
- **Cmd+Shift+P -> Ouvrir la palette de commandes**
  - _Select python interpreter_
  - _Entrez le chemin de l'interpretteur_
  - _/home/user/.local/share/pipx/venvs/django/bin/python_

### Question 8

- **Dans le fichier /workspace/tp3/bonnes_lectures/views.py**

```python
from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def about(request):
  return HttpResponse("Application Bonnes Lectures, développée en TP de Framework Web, Université d’Orléans, 2024")
```

- **Dans le fichier /workspace/tp3/tp3/urls.py**

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("", include("bonnes_lectures.urls"))
    # path('admin/', admin.site.urls),
]
```

- **Créer le fichier /workspace/tp3/bonnes_lectures/urls.py**

```python
from django.urls import path
from . import views

urlpatterns = [
  path("about/", views.about, name="about")
]
```

### Question 9

- **Création d'un fichier tp3/bonnes_lectures/templates/bonnes_lectures/welcome.html**

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bonnes Lectures</title>
  </head>
  <body>
    <h1><b>Bonnes lectures</b></h1>
    <p>
      Vous souhaitez des avis sur les dernières nouveautés littéraires? Vous
      souhaitez des recommendations pertinentes pour choisir votre prochain
      livre? Vous êtes là où il faut! <br />
      Feuilletez les critiques de millions d’ouvrages passés en revue par des
      lecteurs comme vous. <br />
      Créez votre profil, dites-nous quels sont les derniers titres que vous
      avez aimés, ou vos genres favoris, et nous vous conseillerons.
    </p>
  </body>
</html>
```

- **Dans le fichier /workspace/tp3/bonnes_lectures/views.py**

```python
def welcome(request):
  return render(request, "bonnes_lectures/welcome.html")
```

- **Dans le fichier /workspace/tp3/bonnes_lectures/urls.py**

```python
urlpatterns = [
  path("about/", views.about, name="about"),
  path("welcome/", views.welcome, name="welcome")
]
```

### Question 10

- **Dans le fichier /workspace/tp3/bonnes_lectures/models.py**

```python
from django.db import models

# Create your models here.
class Book(models.Model):
  title = models.CharField(max_length=100)
  publisher = models.CharField(max_length=100)
  year = models.DateField()
  isbn = models.CharField(max_length=100)
  backCover = models.TextField()
  cover = models.BooleanField()

  def __str__(self):
    return self.title
```

### Question 11

- `python manage.py makemigrations` _(pour générer les requêtes SQL en examinant le code python)_
- `python manage.py sqlmigrate bonnes_lectures 0001` _(pour afficher le SQL généré)_ _(pas necessaire sert uniquement à vérifier)_
- `python manage.py migrate` _(pour appliquer les migrations)_ _(celle qui n'ont pas encore été appliqués)_

### Question 12

- `python manage.py shell`

- **Dans le shell**

```python
>>>from bonnes_lectures.models import Book
>>>b = Book(title="Freakonomics", publisher="HarperCollins", year="2005-02-28", isbn="978-0060731328", backCover="Freakonomics is a groundbreaking collaboration between Levitt and Stephen J. Dubner, an award-winning author and journalist. They usually begin with a mountain of data and a simple, unasked question. Some of these questions concern life-and-death issues; others have an admittedly freakish quality. Thus the new field of study contained in this book: Freakonomics.", cover=True)
>>>b.save()
>>># optionnel b.id pour vérifier si il y a un id
```

### Question 13

- **mkdir bonnes_lectures/fixtures**
- **python manage.py dumpdata > bonnes_lectures/fixtures/data.json**

### Question 14 _(Optionnelle)_

- **Ajout dans le fichier /workspace/tp3/bonnes_lectures/views.py**

```python
def index(request):
  books = Book.objects.order_by("year")
  context = { "all_book" : books } # Liens template <-> vue
  return render (request , "bonnes_lectures/index.html", context)
```

- **Création du fichier /workspace/tp3/bonnes_lectures/templates/bonnes_lectures/index.html**

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bonnes Lectures</title>
  </head>
  <body>
    <h1><b>Les Livres</b></h1>
    <ul>
      {% for book in all_book %}
      <li>{{ book.title }} ({{ book.year }})</li>
      {% endfor %}
    </ul>
  </body>
</html>
```

- **Dans le fichier /workspace/tp3/bonnes_lectures/urls.py**

```python
urlpatterns = [
  path("about/", views.about, name="about"),
  path("welcome/", views.welcome, name="welcome"),
  path("index/", views.index, name="index") # [+] cette route
]
```
