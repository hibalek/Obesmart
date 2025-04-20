import 'package:flutter/material.dart';

class PatientProfileScreen extends StatelessWidget {
  final String patientName;

  const PatientProfileScreen({super.key, required this.patientName});

  final Map<String, dynamic> patientData = const {
    'age': 34,
    'email': 'patient@email.com',
    'phone': '0555 66 77 88',
    'analyses': [
      {'title': 'Analyse sanguine', 'date': '12/04/2024', 'status': 'Normale'},
      {'title': 'IRM', 'date': '25/03/2024', 'status': 'À revoir'},
    ],
    'medicalFile': 'Le patient souffre d’hypertension légère. Aucun antécédent chirurgical notable.'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil de $patientName"),
        backgroundColor: const Color.fromARGB(255, 12, 67, 111),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(patientName),
                subtitle: Text("Âge: ${patientData['age']} ans"),
                trailing: const Icon(Icons.info_outline),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Dossier Médical",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              patientData['medicalFile'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              "Analyses récentes",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            ...patientData['analyses'].map<Widget>((analysis) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.assignment),
                  title: Text(analysis['title']),
                  subtitle: Text("Date: ${analysis['date']}"),
                  trailing: Text(
                    analysis['status'],
                    style: TextStyle(
                      color: analysis['status'] == 'Normale' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
