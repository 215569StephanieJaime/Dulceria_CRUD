from django.shortcuts import render, redirect
from django.http import HttpResponseRedirect
from django.urls import reverse_lazy

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.mixins import LoginRequiredMixin, \
   PermissionRequiredMixin 
from django.views import generic

class SinPrivilegios(LoginRequiredMixin, PermissionRequiredMixin):
    login_url = 'bases:login'
    raise_exception = False
    redirect_field_name = "redirect_to"

    def handle_no_permission(self):
        from django.contrib.auth.models import AnonymousUser
        if not self.request.user == AnonymousUser():
            self.login_url = 'bases:sin_privilegios'
        return HttpResponseRedirect(reverse_lazy(self.login_url))

class Home(LoginRequiredMixin, generic.TemplateView):
    login_url = "bases:login"
    template_name = 'bases/home.html'
    

class HomeSinPrivilegios(LoginRequiredMixin, generic.TemplateView):
    login_url = "bases:login"
    template_name = "bases/sin_privilegios.html"

def buttons_view(request):
    return render(request, 'base/buttons.html')

def cards_view(request):
    return render(request, 'base/cards.html')

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('bases:home')
        else:
            return render(request, 'bases/login.html', {
                'error': 'Credenciales inválidas. Por favor, vuelve a introducir tu usuario y contraseña.'
            })
    return render(request, 'bases/login.html')

def register_view(request):
    return render(request, 'base/register.html')

def logout_view(request):
    logout(request)
    return redirect('bases:login')