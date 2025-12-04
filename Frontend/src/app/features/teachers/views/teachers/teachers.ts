import { Component, computed, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

type Teacher = {
  id: number;
  nombre: string;
  email: string;
  programa: string;
  cursos: string;
};

@Component({
  selector: 'app-teachers',
  imports: [CommonModule, ReactiveFormsModule, RouterLink, SideMenu],
  templateUrl: './teachers.html',
  styleUrl: './teachers.css',
})
export class Teachers {
  private fb = new FormBuilder();
  private router = inject(Router);

  form = this.fb.group({ q: [''] });

  private data = signal<Teacher[]>([
    { id: 1, nombre: 'Dra. Patricia Vargas', email: 'patricia.vargas@email.com', programa: 'Ingeniería de Software', cursos: 'Bases de Datos' },
    { id: 2, nombre: 'Dr. Roberto Jiménez', email: 'roberto.jimenez@email.com', programa: 'Ingeniería de Software', cursos: 'Calculo Integral' },
    { id: 3, nombre: 'Dra. Carmen Ortiz', email: 'carmen.ortiz@email.com', programa: 'Ingeniería de Software', cursos: 'Modelos y Documentación del Software' },
    { id: 4, nombre: 'Dr. Luis Martínez', email: 'luis.martinez@email.com', programa: 'Ingeniería de Sistemas', cursos: 'Programación Avanzada' },
  ]);

  pageSize = 5;
  page = signal(1);

  filtered = computed(() => {
    const q = (this.form.value.q ?? '').toLowerCase().trim();
    if (!q) return this.data();
    return this.data().filter(t =>
      t.nombre.toLowerCase().includes(q) ||
      t.email.toLowerCase().includes(q) ||
      t.programa.toLowerCase().includes(q) ||
      t.cursos.toLowerCase().includes(q)
    );
  });

  totalPages = computed(() => Math.max(1, Math.ceil(this.filtered().length / this.pageSize)));

  pageItems = computed(() => {
    const start = (this.page() - 1) * this.pageSize;
    return this.filtered().slice(start, start + this.pageSize);
  });

  trackById = (_: number, item: Teacher) => item.id;

  editar(id: number) {
    this.router.navigate(['/teachers/edit', id]);
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
