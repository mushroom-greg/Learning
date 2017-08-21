import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';

@Component({
  templateUrl: 'templates/login.component.html'
})
export class LoginComponent {

  message: string;

  constructor(private authService: AuthService, private router: Router) {
    this.setMessage();
  }

  setMessage() {
    this.message = this.authService.isLoggedIn ? 'Vous êtes connecté.' : 'Vous êtes déconnecté.';
  }

  login() {
    this.message = 'Tentative de connexion en cours ...';
    this.authService.login().subscribe(() => {
      this.setMessage();
      if (this.authService.isLoggedIn) {
        const redirect = this.authService.redirectUrl ? this.authService.redirectUrl : '/pokemon/all';
        this.router.navigate([redirect]);
      }
    });
  }

  logout() {
    this.authService.logout();
    this.setMessage();
  }
}
