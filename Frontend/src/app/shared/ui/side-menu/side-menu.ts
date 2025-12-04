import { CommonModule } from '@angular/common';
import { Component, signal, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-side-menu',
  imports: [CommonModule, RouterLink, RouterLinkActive],
  templateUrl: './side-menu.html',
  styleUrl: './side-menu.css'
})
export class SideMenu {
  private router = inject(Router);

  registroOpen = signal(true); // abre el submenú por defecto
  toggleRegistro() { this.registroOpen.update(v => !v); }

  logout() {
    // Aquí se puede agregar lógica adicional como limpiar tokens, sesión, etc.
    this.router.navigate(['/login']);
  }
}
