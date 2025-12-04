import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Academico',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  'Total de Estudiantes',
                  '20',
                  '+2 desde el último semestre',
                ),
              ),
              SizedBox(width: 16), // Espaciado entre cards
              Expanded(
                child: _buildInfoCard(
                  'Promedio General',
                  '3.7',
                  '+0.2 desde el último semestre',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildChartContainer(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildLegendItem('No Aprobados (< 3.0)', Colors.red),
              _buildLegendItem('Aprobados (3.0 a 3.9)', Colors.orange),
              _buildLegendItem('Aprobados (> 4.0)', Colors.green),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: [
                  PieChartSectionData(
                    color: Colors.red,
                    value: 15,
                    title: '15%',
                    radius: 100,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: 30,
                    title: '30%',
                    radius: 100,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 55,
                    title: '55%',
                    radius: 100,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textColor,
          ),
        ),
      ],
    );
  }
}