import { Component, inject, PLATFORM_ID, AfterViewInit, OnDestroy, signal } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

@Component({
  selector: 'app-reports',
  imports: [CommonModule, ReactiveFormsModule, SideMenu],
  templateUrl: './reports.html',
  styleUrl: './reports.css',
})
export class Reports implements AfterViewInit, OnDestroy {
  private platformId = inject(PLATFORM_ID);
  private fb = new FormBuilder();
  private chart: Chart | null = null;

  reportGenerated = signal(false);

  filtersForm = this.fb.group({
    tipoReporte: [''],
    programaAcademico: [''],
    cursoMateria: [''],
    estudiante: [''],
    fecha: [''],
    nivelDesempeno: [''],
  });

  ngAfterViewInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    // El gráfico se creará cuando se genere el reporte
  }

  generarReporte() {
    this.reportGenerated.set(true);
    if (!isPlatformBrowser(this.platformId)) return;

    setTimeout(() => {
      this.createChart();
    }, 100);
  }

  private createChart() {
    const canvas = document.getElementById('reportChart') as HTMLCanvasElement;
    if (!canvas) return;

    // Destruir gráfico anterior si existe
    if (this.chart) {
      this.chart.destroy();
    }

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: [
          'Pensamiento Critico',
          'Resolucion de Problemas',
          'Comunicacion Efectiva',
          'Trabajo en Equipo',
          'Competencia Digital',
          'Etica Profesional'
        ],
        datasets: [{
          label: 'Nivel Alcanzado',
          data: [85, 72, 90, 65, 78, 95],
          backgroundColor: [
            'rgba(94, 234, 212, 0.8)',  // turquesa
            'rgba(253, 224, 71, 0.8)',   // amarillo
            'rgba(94, 234, 212, 0.8)',   // turquesa
            'rgba(251, 146, 60, 0.8)',   // naranja
            'rgba(253, 224, 71, 0.8)',   // amarillo
            'rgba(94, 234, 212, 0.8)',   // turquesa
          ],
          borderColor: [
            'rgba(94, 234, 212, 1)',
            'rgba(253, 224, 71, 1)',
            'rgba(94, 234, 212, 1)',
            'rgba(251, 146, 60, 1)',
            'rgba(253, 224, 71, 1)',
            'rgba(94, 234, 212, 1)',
          ],
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
          legend: {
            display: true,
            position: 'top',
            align: 'center',
            labels: {
              usePointStyle: true,
              padding: 20,
              font: {
                size: 12
              }
            }
          },
          title: {
            display: true,
            text: 'Resultados de Aprendizaje por Nivel',
            font: {
              size: 16,
              weight: 'normal'
            },
            padding: {
              bottom: 30
            }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            max: 100,
            ticks: {
              stepSize: 10
            },
            grid: {
              color: 'rgba(0, 0, 0, 0.05)'
            }
          },
          x: {
            grid: {
              display: false
            }
          }
        }
      }
    });
  }

  exportarPDF() {
    console.log('Exportar a PDF');
    // TODO: Implementar exportación a PDF
  }

  exportarExcel() {
    console.log('Exportar a Excel');
    // TODO: Implementar exportación a Excel
  }

  actualizarReporte() {
    console.log('Actualizar reporte');
    this.generarReporte();
  }

  ngOnDestroy() {
    if (this.chart) {
      this.chart.destroy();
    }
  }
}
