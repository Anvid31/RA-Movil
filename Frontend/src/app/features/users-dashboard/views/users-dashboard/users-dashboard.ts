import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

type StatCard = {
  value: number;
  label: string;
};

type ControlPanelOption = {
  title: string;
  description: string;
  route: string;
  icon: string;
};

@Component({
  selector: 'app-users-dashboard',
  imports: [CommonModule, SideMenu],
  templateUrl: './users-dashboard.html',
  styleUrl: './users-dashboard.css',
})
export class UsersDashboard {
  registrarMenuOpen = signal(false);

  stats: StatCard[] = [
    { value: 5, label: 'Estudiantes' },
    { value: 4, label: 'Profesores' },
    { value: 5, label: 'Programas' },
  ];

  controlPanelOptions: ControlPanelOption[] = [
    {
      title: 'Estudiantes',
      description: 'Gestionar estudiantes registrados',
      route: '/students',
      icon: 'student'
    },
    {
      title: 'Docentes',
      description: 'Gestionar Docentes registrados',
      route: '/teachers',
      icon: 'teacher'
    },
    {
      title: 'Programas Académicos',
      description: 'Gestionar programas académicos',
      route: '/programs',
      icon: 'graduation'
    }
  ];

  constructor(private router: Router) {}

  toggleRegistrarMenu() {
    this.registrarMenuOpen.update(v => !v);
  }

  navigateTo(route: string) {
    this.router.navigate([route]);
  }

  registrarEstudiante() {
    this.registrarMenuOpen.set(false);
    this.router.navigate(['/students/new']);
  }

  registrarDocente() {
    this.registrarMenuOpen.set(false);
    this.router.navigate(['/teachers']);
  }

  registrarPrograma() {
    this.registrarMenuOpen.set(false);
    this.router.navigate(['/programs']);
  }
}
