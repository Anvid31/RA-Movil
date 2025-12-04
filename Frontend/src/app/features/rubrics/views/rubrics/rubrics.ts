import { Component, computed, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

type Rubric = {
  id: number;
  nombre: string;
  codigoRA: string;
  competencia: string;
  programa: string;
  fechaCreacion: string;
};

@Component({
  selector: 'app-rubrics',
  imports: [CommonModule, ReactiveFormsModule, RouterLink, SideMenu],
  templateUrl: './rubrics.html',
  styleUrl: './rubrics.css',
})
export class Rubrics {
  private fb = new FormBuilder();
  private router = inject(Router);

  form = this.fb.group({ q: [''] });

  private data = signal<Rubric[]>([
    { id: 1, nombre: 'Evaluación de Proyecto Final', codigoRA: 'RA-2023-001', competencia: 'Desarrollo de Soluciones', programa: 'Ingeniería de Software', fechaCreacion: '15/04/2023' },
    { id: 2, nombre: 'Presentación Oral', codigoRA: 'RA-2023-002', competencia: 'Comunicación Efectiva', programa: 'Ingeniería de Software', fechaCreacion: '22/05/2023' },
    { id: 3, nombre: 'Análisis de Caso Legal', codigoRA: 'RA-2023-003', competencia: 'Análisis Crítico', programa: 'Ingeniería de Software', fechaCreacion: '10/06/2023' },
    { id: 4, nombre: 'Diseño Arquitectónico', codigoRA: 'RA-2023-004', competencia: 'Diseño Creativo', programa: 'Ingeniería de Software', fechaCreacion: '05/07/2023' },
    { id: 5, nombre: 'Evaluación Psicológica', codigoRA: 'RA-2023-005', competencia: 'Evaluación Clínica', programa: 'Ingeniería de Software', fechaCreacion: '18/08/2023' },
    { id: 6, nombre: 'Trabajo en Equipo Colaborativo', codigoRA: 'RA-2023-006', competencia: 'Colaboración', programa: 'Ingeniería de Software', fechaCreacion: '25/09/2023' },
    { id: 7, nombre: 'Investigación Científica', codigoRA: 'RA-2023-007', competencia: 'Pensamiento Científico', programa: 'Medicina', fechaCreacion: '12/10/2023' },
  ]);

  pageSize = 5;
  page = signal(1);

  filtered = computed(() => {
    const q = (this.form.value.q ?? '').toLowerCase().trim();
    if (!q) return this.data();
    return this.data().filter(r =>
      r.nombre.toLowerCase().includes(q) ||
      r.codigoRA.toLowerCase().includes(q) ||
      r.competencia.toLowerCase().includes(q) ||
      r.programa.toLowerCase().includes(q)
    );
  });

  totalPages = computed(() => Math.max(1, Math.ceil(this.filtered().length / this.pageSize)));

  pageItems = computed(() => {
    const start = (this.page() - 1) * this.pageSize;
    return this.filtered().slice(start, start + this.pageSize);
  });

  trackById = (_: number, item: Rubric) => item.id;

  editar(id: number) {
    this.router.navigate(['/register-ra/edit', id]);
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
