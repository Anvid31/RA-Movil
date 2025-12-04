import { Component, OnInit, inject, computed, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormArray, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

type Criterion = {
  descripcion: string;
  nivel: number;
  comentarios: string;
};

@Component({
  selector: 'app-rubric-register',
  imports: [CommonModule, ReactiveFormsModule, SideMenu],
  templateUrl: './rubric-register.html',
  styleUrl: './rubric-register.css',
})
export class RubricRegister implements OnInit {
  private fb = new FormBuilder();
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  isEditMode = false;
  rubricId?: number;

  // Datos mock para los dropdowns
  competencias = [
    { value: 'desarrollo-soluciones', label: 'Desarrollo de Soluciones' },
    { value: 'comunicacion-efectiva', label: 'Comunicación Efectiva' },
    { value: 'analisis-critico', label: 'Análisis Crítico' },
    { value: 'diseno-creativo', label: 'Diseño Creativo' },
    { value: 'evaluacion-clinica', label: 'Evaluación Clínica' },
    { value: 'colaboracion', label: 'Colaboración' },
    { value: 'pensamiento-cientifico', label: 'Pensamiento Científico' },
  ];

  programas = [
    { value: 'ingenieria-software', label: 'Ingeniería de Software' },
    { value: 'medicina', label: 'Medicina' },
    { value: 'derecho', label: 'Derecho' },
    { value: 'arquitectura', label: 'Arquitectura' },
    { value: 'psicologia', label: 'Psicología' },
  ];

  registerForm = this.fb.group({
    nombreRA: ['', Validators.required],
    codigoRA: ['', Validators.required],
    competencia: ['', Validators.required],
    programa: ['', Validators.required],
    nombreEstudiante: ['', Validators.required],
    codigoEstudiante: ['', Validators.required],
    nombreDocente: ['', Validators.required],
    codigoDocente: ['', Validators.required],
    criterios: this.fb.array([]),
  });

  ngOnInit() {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.rubricId = parseInt(id, 10);
      this.isEditMode = true;
      this.loadRubricData(this.rubricId);
    } else {
      // Iniciar con 3 criterios por defecto
      this.addCriterion();
      this.addCriterion();
      this.addCriterion();
    }
  }

  get criterios() {
    return this.registerForm.get('criterios') as FormArray;
  }

  addCriterion() {
    const criterionGroup = this.fb.group({
      descripcion: ['', Validators.required],
      nivel: [null, Validators.required],
      comentarios: [''],
    });
    this.criterios.push(criterionGroup);
  }

  removeCriterion(index: number) {
    if (this.criterios.length > 1) {
      this.criterios.removeAt(index);
    }
  }

  // Calcular promedio final basado en los niveles seleccionados
  promedioFinal = computed(() => {
    const criteriosValidos = this.criterios.controls.filter(
      (c) => c.value.nivel !== null
    );
    if (criteriosValidos.length === 0) return 0;

    const suma = criteriosValidos.reduce((acc, c) => acc + (c.value.nivel || 0), 0);
    return (suma / criteriosValidos.length).toFixed(2);
  });

  loadRubricData(id: number) {
    // Aquí se cargarían los datos reales desde el backend
    // Por ahora usamos datos mock
    const mockData = {
      nombreRA: 'Evaluación de Proyecto Final',
      codigoRA: 'RA-2023-001',
      competencia: 'desarrollo-soluciones',
      programa: 'ingenieria-software',
      nombreEstudiante: 'Juan Pérez',
      codigoEstudiante: 'EST-2023-001',
      nombreDocente: 'María García',
      codigoDocente: 'DOC-2023-001',
      criterios: [
        { descripcion: 'Cumplimiento de objetivos', nivel: 4, comentarios: 'Buen trabajo' },
        { descripcion: 'Calidad del código', nivel: 5, comentarios: 'Excelente' },
        { descripcion: 'Documentación', nivel: 3, comentarios: 'Mejorar' },
      ],
    };

    this.registerForm.patchValue({
      nombreRA: mockData.nombreRA,
      codigoRA: mockData.codigoRA,
      competencia: mockData.competencia,
      programa: mockData.programa,
      nombreEstudiante: mockData.nombreEstudiante,
      codigoEstudiante: mockData.codigoEstudiante,
      nombreDocente: mockData.nombreDocente,
      codigoDocente: mockData.codigoDocente,
    });

    // Cargar criterios
    mockData.criterios.forEach((criterio) => {
      const criterionGroup = this.fb.group({
        descripcion: [criterio.descripcion, Validators.required],
        nivel: [criterio.nivel, Validators.required],
        comentarios: [criterio.comentarios],
      });
      this.criterios.push(criterionGroup);
    });
  }

  onSubmit() {
    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    console.log('Formulario enviado:', this.registerForm.value);
    console.log('Promedio final:', this.promedioFinal());

    // Aquí se enviaría al backend
    // Por ahora solo navegamos de vuelta a la lista
    this.router.navigate(['/register-ra']);
  }

  onCancel() {
    this.router.navigate(['/register-ra']);
  }
}
