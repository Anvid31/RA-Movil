import { Component, computed, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

type Program = {
  id: number;
  nombre: string;
  facultad: string;
  duracion: string;
  coordinador: string;
};

@Component({
  selector: 'app-programs',
  imports: [CommonModule, ReactiveFormsModule, RouterLink, SideMenu],
  templateUrl: './programs.html',
  styleUrl: './programs.css',
})
export class Programs {
  private fb = new FormBuilder();
  private router = inject(Router);

  form = this.fb.group({ q: [''] });

  private data = signal<Program[]>([
    { id: 1, nombre: 'Ingeniería de Sistemas', facultad: 'Ingeniería', duracion: '10 semestres', coordinador: 'Dr. Alejandro Martínez' },
    { id: 2, nombre: 'Medicina', facultad: 'Ciencias de la Salud', duracion: '12 semestres', coordinador: 'Dra. Patricia Vargas' },
    { id: 3, nombre: 'Derecho', facultad: 'Ciencias Jurídicas', duracion: '10 semestres', coordinador: 'Dr. Roberto Jiménez' },
    { id: 4, nombre: 'Psicología', facultad: 'Ciencias Humanas', duracion: '8 semestres', coordinador: 'Dra. Carmen Ortiz' },
    { id: 5, nombre: 'Arquitectura', facultad: 'Artes y Diseño', duracion: '10 semestres', coordinador: 'Dr. Fernando López' },
    { id: 6, nombre: 'Ingeniería de Software', facultad: 'Ingeniería', duracion: '10 semestres', coordinador: 'Dr. Luis Martínez' },
    { id: 7, nombre: 'Administración Financiera', facultad: 'Ciencias Económicas', duracion: '8 semestres', coordinador: 'Dra. Ana Rodríguez' },
  ]);

  pageSize = 5;
  page = signal(1);

  filtered = computed(() => {
    const q = (this.form.value.q ?? '').toLowerCase().trim();
    if (!q) return this.data();
    return this.data().filter(p =>
      p.nombre.toLowerCase().includes(q) ||
      p.facultad.toLowerCase().includes(q) ||
      p.coordinador.toLowerCase().includes(q)
    );
  });

  totalPages = computed(() => Math.max(1, Math.ceil(this.filtered().length / this.pageSize)));

  pageItems = computed(() => {
    const start = (this.page() - 1) * this.pageSize;
    return this.filtered().slice(start, start + this.pageSize);
  });

  trackById = (_: number, item: Program) => item.id;

  editar(id: number) {
    this.router.navigate(['/programs/edit', id]);
  }

  eliminar(id: number) {
    this.data.set(this.data().filter(x => x.id !== id));
    if ((this.page() - 1) * this.pageSize >= this.filtered().length) {
      this.page.set(Math.max(1, this.page() - 1));
    }
  }

  prev() { this.page.set(Math.max(1, this.page() - 1)); }
  next() { this.page.set(Math.min(this.totalPages(), this.page() + 1)); }
}
