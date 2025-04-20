import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Map<String, String>> patients = const [
    {'name': 'Ahmed B.', 'date': '12/04/2025', 'id': '1', 'photo': 'assets/ahmed.jpg'},
    {'name': 'Lina K.', 'date': '10/04/2025', 'id': '2', 'photo': 'assets/lina.jpg'},
    {'name': 'Samir T.', 'date': '08/04/2025', 'id': '3', 'photo': 'assets/samir.jpg'},
  ];

  void _viewPatientProfile(BuildContext context, String patientId) {
    final patientDetails = {
      '1': {'name': 'Ahmed B.', 'age': '45', 'diagnosis': 'Hypertension', 'medicalHistory': 'Aucune complication majeure'},
      '2': {'name': 'Lina K.', 'age': '30', 'diagnosis': 'Asthme', 'medicalHistory': 'Allergies saisonnières'},
      '3': {'name': 'Samir T.', 'age': '60', 'diagnosis': 'Diabète', 'medicalHistory': 'Antécédent familial de diabète'},
    };

    final patient = patientDetails[patientId];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Profil de ${patient!['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(patients.firstWhere((p) => p['id'] == patientId)['photo']!),
              ),
              const SizedBox(height: 10),
              Text('Nom: ${patient['name']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Text('Âge: ${patient['age']}', style: TextStyle(fontSize: 14)),
              Text('Diagnostic: ${patient['diagnosis']}', style: TextStyle(fontSize: 14)),
              Text('Antécédents médicaux: ${patient['medicalHistory']}', style: TextStyle(fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de bord"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Patients consultés récemment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Positioned(
                    left: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    bottom: -50,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.2),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Column(
                    children: patients.map((patient) => Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(patient['photo']!),
                          radius: 25,
                        ),
                        title: Text(patient['name']!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                        subtitle: Text("Consulté le: ${patient['date']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.visibility, size: 30),
                          color: Colors.green,
                          onPressed: () => _viewPatientProfile(context, patient['id']!),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Statistiques par jour", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 200, child: DailyStatsChart()),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyStatsChart extends StatelessWidget {
  const DailyStatsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Lun');
                  case 1:
                    return const Text('Mar');
                  case 2:
                    return const Text('Mer');
                  case 3:
                    return const Text('Jeu');
                  case 4:
                    return const Text('Ven');
                  case 5:
                    return const Text('Sam');
                  case 6:
                    return const Text('Dim');
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1),
              FlSpot(1, 1.5),
              FlSpot(2, 1.4),
              FlSpot(3, 3.4),
              FlSpot(4, 2),
              FlSpot(5, 2.2),
              FlSpot(6, 1.8),
            ],
            isCurved: true,
            barWidth: 3,
            color: Colors.blue,
            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
            dotData: FlDotData(show: true),
          ),
        ],
        gridData: FlGridData(show: true),
        minY: 0,
      ),
    );
  }
}
