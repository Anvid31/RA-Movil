import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators, AbstractControl, ValidationErrors } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

@Component({
  selector: 'app-teacher-register',
  imports: [CommonModule, ReactiveFormsModule, SideMenu],
  templateUrl: './teacher-register.html',
  styleUrl: './teacher-register.css',
})
export class TeacherRegister implements OnInit {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  teacherId: number | null = null;
  isEditMode = false;

  registerForm = this.fb.group({
    nombre: ['', [Validators.required]],
    apellido: ['', [Validators.required]],
    email: ['', [Validators.required, Validators.email]],
    tipoDocumento: ['', [Validators.required]],
    numeroDocumento: ['', [Validators.required]],
    password: ['', [Validators.required, Validators.minLength(6)]],
    confirmPassword: ['', [Validators.required]]
  }, {
    validators: this.passwordMatchValidator
  });

  documentTypes = [
    { value: 'CC', label: 'Cédula de Ciudadanía' },
    { value: 'TI', label: 'Tarjeta de Identidad' },
    { value: 'CE', label: 'Cédula de Extranjería' },
    { value: 'PP', label: 'Pasaporte' }
  ];

  ngOnInit() {
    // Check if we're in edit mode
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.teacherId = parseInt(id, 10);
      this.isEditMode = true;
      this.loadTeacherData(this.teacherId);
    }
  }

  loadTeacherData(id: number) {
    // TODO: Load teacher data from service
    // For now, using mock data
    const mockTeachers = [
      { id: 1, nombre: 'Patricia', apellido: 'Vargas', email: 'patricia.vargas@email.com', tipoDocumento: 'CC', numeroDocumento: '1234567890' },
      { id: 2, nombre: 'Roberto', apellido: 'Jiménez', email: 'roberto.jimenez@email.com', tipoDocumento: 'CC', numeroDocumento: '9876543210' },
      { id: 3, nombre: 'Carmen', apellido: 'Ortiz', email: 'carmen.ortiz@email.com', tipoDocumento: 'CC', numeroDocumento: '5555555555' },
      { id: 4, nombre: 'Luis', apellido: 'Martínez', email: 'luis.martinez@email.com', tipoDocumento: 'CC', numeroDocumento: '1111111111' },
    ];

    const teacher = mockTeachers.find(t => t.id === id);
    if (teacher) {
      this.registerForm.patchValue({
        nombre: teacher.nombre,
        apellido: teacher.apellido,
        email: teacher.email,
        tipoDocumento: teacher.tipoDocumento,
        numeroDocumento: teacher.numeroDocumento,
        password: '',
        confirmPassword: ''
      });
    }
  }

  // Custom validator to check if passwords match
  passwordMatchValidator(control: AbstractControl): ValidationErrors | null {
    const password = control.get('password');
    const confirmPassword = control.get('confirmPassword');

    if (!password || !confirmPassword) {
      return null;
    }

    return password.value === confirmPassword.value ? null : { passwordMismatch: true };
  }

  onCancel() {
    this.router.navigate(['/teachers']);
  }

  onSubmit() {
    if (this.registerForm.valid) {
      if (this.isEditMode) {
        console.log('Updating teacher:', this.teacherId, this.registerForm.value);
        // TODO: Implement teacher update
      } else {
        console.log('Registering teacher:', this.registerForm.value);
        // TODO: Implement teacher save
      }
      this.router.navigate(['/teachers']);
    } else {
      // Mark all fields as touched to show errors
      Object.keys(this.registerForm.controls).forEach(key => {
        this.registerForm.get(key)?.markAsTouched();
      });
    }
  }
}
