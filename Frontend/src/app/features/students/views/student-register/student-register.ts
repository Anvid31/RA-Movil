import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

@Component({
  selector: 'app-student-register',
  imports: [CommonModule, ReactiveFormsModule, SideMenu],
  templateUrl: './student-register.html',
  styleUrl: './student-register.css',
})
export class StudentRegister implements OnInit {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  studentId: number | null = null;
  isEditMode = false;

  registerForm = this.fb.group({
    nombre: ['', [Validators.required]],
    apellido: ['', [Validators.required]],
    email: ['', [Validators.required, Validators.email]],
    tipoDocumento: ['', [Validators.required]],
    numeroDocumento: ['', [Validators.required]],
    programa: ['', [Validators.required]],
    semestre: ['', [Validators.required, Validators.min(1), Validators.max(10)]]
  });

  documentTypes = [
    { value: 'CC', label: 'Cédula de Ciudadanía' },
    { value: 'TI', label: 'Tarjeta de Identidad' },
    { value: 'CE', label: 'Cédula de Extranjería' },
    { value: 'PP', label: 'Pasaporte' }
  ];

  programs = [
    { value: 'ISW', label: 'Ingeniería de Software' },
    { value: 'ISI', label: 'Ingeniería de Sistemas' },
    { value: 'IND', label: 'Ingeniería Industrial' },
    { value: 'ADM', label: 'Administración de Empresas' }
  ];

  ngOnInit() {
    // Check if we're in edit mode
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.studentId = parseInt(id, 10);
      this.isEditMode = true;
      this.loadStudentData(this.studentId);
    }
  }

  loadStudentData(id: number) {
    // TODO: Load student data from service
    // For now, using mock data
    const mockStudents = [
      { id: 1, nombre: 'Ana María', apellido: 'Rodríguez', email: 'ana.rodriguez@email.com', tipoDocumento: 'CC', numeroDocumento: '1234567890', programa: 'ISW', semestre: 3 },
      { id: 2, nombre: 'Carlos', apellido: 'Sánchez', email: 'carlos.sanchez@email.com', tipoDocumento: 'CC', numeroDocumento: '9876543210', programa: 'ISW', semestre: 5 },
      { id: 3, nombre: 'Luisa Fernanda', apellido: 'Gómez', email: 'luisa.gomez@email.com', tipoDocumento: 'CC', numeroDocumento: '5555555555', programa: 'ISW', semestre: 7 },
      { id: 4, nombre: 'Juan David', apellido: 'Mendoza', email: 'juan.mendoza@email.com', tipoDocumento: 'CC', numeroDocumento: '1111111111', programa: 'ISW', semestre: 2 },
      { id: 5, nombre: 'Valentina', apellido: 'Torres', email: 'valentina.torres@email.com', tipoDocumento: 'CC', numeroDocumento: '2222222222', programa: 'ISW', semestre: 4 },
    ];

    const student = mockStudents.find(s => s.id === id);
    if (student) {
      this.registerForm.patchValue({
        nombre: student.nombre,
        apellido: student.apellido,
        email: student.email,
        tipoDocumento: student.tipoDocumento,
        numeroDocumento: student.numeroDocumento,
        programa: student.programa,
        semestre: student.semestre.toString()
      });
    }
  }

  onCancel() {
    this.router.navigate(['/students']);
  }

  onImport() {
    // TODO: Implement student import from file
    console.log('Import students');
  }

  onSubmit() {
    if (this.registerForm.valid) {
      if (this.isEditMode) {
        console.log('Updating student:', this.studentId, this.registerForm.value);
        // TODO: Implement student update
      } else {
        console.log('Registering student:', this.registerForm.value);
        // TODO: Implement student save
      }
      this.router.navigate(['/students']);
    } else {
      // Mark all fields as touched to show errors
      Object.keys(this.registerForm.controls).forEach(key => {
        this.registerForm.get(key)?.markAsTouched();
      });
    }
  }
}
