import { Routes } from '@angular/router';
import { Login } from './features/auth/views/login/login';
import { Home } from './features/home/views/home/home';
import { Students } from './features/students/views/students/students';
import { StudentRegister } from './features/students/views/student-register/student-register';
import { Teachers } from './features/teachers/views/teachers/teachers';
import { TeacherRegister } from './features/teachers/views/teacher-register/teacher-register';
import { Programs } from './features/programs/views/programs/programs';
import { ProgramRegister } from './features/programs/views/program-register/program-register';
import { Reports } from './features/reports/views/reports/reports';
import { UsersDashboard } from './features/users-dashboard/views/users-dashboard/users-dashboard';
import { Rubrics } from './features/rubrics/views/rubrics/rubrics';
import { RubricRegister } from './features/rubrics/views/rubric-register/rubric-register';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'login', component: Login },
  { path: 'home', component: Home },
  { path: 'students', component: Students },
  { path: 'students/new', component: StudentRegister },
  { path: 'students/edit/:id', component: StudentRegister },
  { path: 'teachers', component: Teachers },
  { path: 'teachers/new', component: TeacherRegister },
  { path: 'teachers/edit/:id', component: TeacherRegister },
  { path: 'programs', component: Programs },
  { path: 'programs/new', component: ProgramRegister },
  { path: 'programs/edit/:id', component: ProgramRegister },
  { path: 'register-ra', component: Rubrics },
  { path: 'register-ra/new', component: RubricRegister },
  { path: 'register-ra/edit/:id', component: RubricRegister },
  { path: 'reports', component: Reports },
  { path: 'users-dashboard', component: UsersDashboard },
  { path: '**', redirectTo: 'login' },
];
