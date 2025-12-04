import { Component, computed, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

type Student = {
  id: number;
  nombre: string;
  email: string;
  programa: string;
  semestre: number;
};

@Component({
  selector: 'app-students',
  imports: [CommonModule, ReactiveFormsModule, RouterLink, SideMenu],
  templateUrl: './students.html',
  styleUrl: './students.css',
})
export class Students {
  private fb = new FormBuilder();
  private router = inject(Router);

  form = this.fb.group({ q: [''] });

  private data = signal<Student[]>([
    { id: 1, nombre: 'Ana María Rodríguez',  email: 'ana.rodriguez@email.com',   programa: 'Ingeniería de Software', semestre: 3 },
    { id: 2, nombre: 'Carlos Sánchez',       email: 'carlos.sanchez@email.com',  programa: 'Ingeniería de Software', semestre: 5 },
    { id: 3, nombre: 'Luisa Fernanda Gómez', email: 'luisa.gomez@email.com',     programa: 'Ingeniería de Software', semestre: 7 },
    { id: 4, nombre: 'Juan David Mendoza',   email: 'juan.mendoza@email.com',    programa: 'Ingeniería de Software', semestre: 2 },
    { id: 5, nombre: 'Valentina Torres',     email: 'valentina.torres@email.com',programa: 'Ingeniería de Software', semestre: 4 },
  ]);

  pageSize = 5;
  page = signal(1);

  filtered = computed(() => {
    const q = (this.form.value.q ?? '').toLowerCase().trim();
    if (!q) return this.data();
    return this.data().filter(s =>
      s.nombre.toLowerCase().includes(q) ||
      s.email.toLowerCase().includes(q) ||
      s.programa.toLowerCase().includes(q)
    );
  });

  totalPages = computed(() => Math.max(1, Math.ceil(this.filtered().length / this.pageSize)));

  pageItems = computed(() => {
    const start = (this.page() - 1) * this.pageSize;
    return this.filtered().slice(start, start + this.pageSize);
  });

  // ✅ trackBy correcto
  trackById = (_: number, item: Student) => item.id;

  editar(id: number) {
    this.router.navigate(['/students/edit', id]);
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