from django.urls import path
from .views import Home, login_view, register_view, logout_view, buttons_view, cards_view, HomeSinPrivilegios

app_name = 'bases'

urlpatterns = [
    path('', login_view, name='login'), 
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
    path('register/', register_view, name='register'),
    path('home/', Home.as_view(), name='home'),
    path('buttons/', buttons_view, name='buttons'),
    path('cards/', cards_view, name='cards'),
    path('sin_privilegios/', HomeSinPrivilegios.as_view(), name='sin_privilegios'),

    
]


