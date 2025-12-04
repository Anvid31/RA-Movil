import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

@Component({
  selector: 'app-program-register',
  imports: [CommonModule, ReactiveFormsModule, SideMenu],
  templateUrl: './program-register.html',
  styleUrl: './program-register.css',
})
export class ProgramRegister implements OnInit {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  programId: number | null = null;
  isEditMode = false;

  registerForm = this.fb.group({
    nombre: ['', [Validators.required]],
    codigo: ['', [Validators.required]],
    sede: ['', [Validators.required]],
    semestres: ['', [Validators.required, Validators.min(1), Validators.max(20)]],
    descripcion: ['', [Validators.required]]
  });

  sedes = [
    { value: 'bogota', label: 'Bogotá' },
    { value: 'medellin', label: 'Medellín' },
    { value: 'cali', label: 'Cali' },
    { value: 'barranquilla', label: 'Barranquilla' },
    { value: 'cucuta', label: 'Cúcuta' }
  ];

  ngOnInit() {
    // Check if we're in edit mode
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.programId = parseInt(id, 10);
      this.isEditMode = true;
      this.loadProgramData(this.programId);
    }
  }

  loadProgramData(id: number) {
    // TODO: Load program data from service
    // For now, using mock data
    const mockPrograms = [
      { id: 1, nombre: 'Ingeniería de Sistemas', codigo: '1001', sede: 'bogota', semestres: 10, descripcion: 'Programa de formación en sistemas' },
      { id: 2, nombre: 'Medicina', codigo: '2001', sede: 'medellin', semestres: 12, descripcion: 'Programa de formación médica' },
      { id: 3, nombre: 'Derecho', codigo: '3001', sede: 'cali', semestres: 10, descripcion: 'Programa de formación jurídica' },
      { id: 4, nombre: 'Psicología', codigo: '4001', sede: 'barranquilla', semestres: 8, descripcion: 'Programa de formación en psicología' },
      { id: 5, nombre: 'Arquitectura', codigo: '5001', sede: 'bogota', semestres: 10, descripcion: 'Programa de formación en arquitectura' },
      { id: 6, nombre: 'Ingeniería de Software', codigo: '1945783426', sede: 'bogota', semestres: 10, descripcion: 'El programa académico de Ingeniería de Software forma profesionales capaces de diseñar, desarrollar, implementar y mantener sistemas de software de alta calidad, aplicando principios de la ingeniería y las ciencias de la computación.' },
    ];

    const program = mockPrograms.find(p => p.id === id);
    if (program) {
      this.registerForm.patchValue({
        nombre: program.nombre,
        codigo: program.codigo,
        sede: program.sede,
        semestres: program.semestres.toString(),
        descripcion: program.descripcion
      });
    }
  }

  onCancel() {
    this.router.navigate(['/programs']);
  }

  onSubmit() {
    if (this.registerForm.valid) {
      if (this.isEditMode) {
        console.log('Updating program:', this.programId, this.registerForm.value);
        // TODO: Implement program update
      } else {
        console.log('Registering program:', this.registerForm.value);
        // TODO: Implement program save
      }
      this.router.navigate(['/programs']);
    } else {
      // Mark all fields as touched to show errors
      Object.keys(this.registerForm.controls).forEach(key => {
        this.registerForm.get(key)?.markAsTouched();
      });
    }
  }
}
