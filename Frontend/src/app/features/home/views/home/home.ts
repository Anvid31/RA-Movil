import { AfterViewInit, Component, OnDestroy, inject } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { ReactiveFormsModule, FormBuilder } from '@angular/forms';
import { PLATFORM_ID } from '@angular/core';

import {
  Chart,
  registerables,
  type ChartConfiguration,
  type ChartType,
} from 'chart.js';

import { SideMenu } from '../../../../shared/ui/side-menu/side-menu';

Chart.register(...registerables);

@Component({
  selector: 'app-home',
  imports: [CommonModule, ReactiveFormsModule, SideMenu],
  templateUrl: './home.html',
  styleUrl: './home.css',
})
export class Home implements AfterViewInit, OnDestroy {
  private platformId = inject(PLATFORM_ID);
  private chart?: Chart;
  private canvasEl?: HTMLCanvasElement;
  private currentType?: ChartType; // ✅ llevamos el tipo aquí

  readonly form = inject(FormBuilder).group({
    vista: 'distribucion' as 'distribucion' | 'rendimiento',
    curso: 'todos' as 'todos' | 'curso1' | 'curso2',
  });

  ngAfterViewInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    this.canvasEl = document.getElementById('gradesChart') as HTMLCanvasElement | null || undefined;
    if (!this.canvasEl) return;

    const cfg = this.getConfig();
    this.chart = new Chart(this.canvasEl, cfg);
    this.currentType = cfg.type; // ✅ guarda el tipo actual

    this.form.valueChanges.subscribe(() => this.updateChart());
  }

  ngOnDestroy() {
    this.chart?.destroy();
  }

  private updateChart() {
    if (!this.canvasEl) return;

    const newCfg = this.getConfig();
    // 👇 comparamos con el tipo que llevamos nosotros
    if (!this.chart || this.currentType !== newCfg.type) {
      this.chart?.destroy();
      this.chart = new Chart(this.canvasEl, newCfg);
      this.currentType = newCfg.type; // ✅ actualiza el tipo
    } else {
      this.chart.data = newCfg.data!;
      this.chart.options = newCfg.options!;
      this.chart.update();
    }
  }

  private getConfig(): ChartConfiguration<'pie' | 'bar', number[], string> {
    const vista = this.form.get('vista')!.value as 'distribucion' | 'rendimiento';
    const curso = this.form.get('curso')!.value as string;

    const dataSet = (() => {
      if (curso === 'curso1') return [60, 25, 15];
      if (curso === 'curso2') return [50, 35, 15];
      return [55, 30, 15];
    })();

    if (vista === 'distribucion') {
      return {
        type: 'pie',
        data: {
          labels: ['Aprobados (>4)', 'Aprobados', 'No Aprobados (>3)'],
          datasets: [{
            data: dataSet,
            backgroundColor: ['#10B981', '#FBBF24', '#EF4444'],
            borderWidth: 0,
            borderRadius: 4
          }],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'bottom',
              labels: {
                padding: 20,
                font: {
                  size: 13,
                  family: "'Inter', sans-serif"
                },
                usePointStyle: true,
                pointStyle: 'circle'
              }
            },
            tooltip: {
              backgroundColor: 'rgba(0, 0, 0, 0.8)',
              padding: 12,
              bodyFont: {
                size: 13
              },
              callbacks: {
                label: (context) => {
                  const label = context.label || '';
                  const value = context.parsed || 0;
                  return `${label}: ${value}%`;
                }
              }
            }
          }
        },
      };
    }

    return {
      type: 'bar',
      data: {
        labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
        datasets: [{
          label: 'Promedio',
          data: [3.4, 3.5, 3.6, 3.7, 3.8, 3.7],
          backgroundColor: '#BF0009',
          borderRadius: 6
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: true,
            position: 'bottom',
            labels: {
              padding: 15,
              font: {
                size: 13,
                family: "'Inter', sans-serif"
              },
              usePointStyle: true
            }
          },
          tooltip: {
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            padding: 12,
            bodyFont: {
              size: 13
            }
          }
        },
        scales: {
          y: {
            min: 0,
            max: 5,
            ticks: {
              stepSize: 1,
              font: {
                size: 12
              }
            },
            grid: {
              color: 'rgba(0, 0, 0, 0.05)'
            }
          },
          x: {
            ticks: {
              font: {
                size: 12
              }
            },
            grid: {
              display: false
            }
          }
        }
      },
    };
  }
}