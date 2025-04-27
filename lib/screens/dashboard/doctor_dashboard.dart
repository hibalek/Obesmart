import 'package:flutter/material.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(vc
        title: const Text('Tableau de bord du Médecin'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue, Docteur!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            const Text(
              'Vos patients récents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // Exemple: Liste de 5 patients
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Patient ${index + 1}'),
                  subtitle: const Text('Dernière consultation: 20/04/2025'),
                  onTap: () {
                    // Navigation vers les détails du patient
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Logique pour prendre un rendez-vous
              },
              child: const Text('Prendre un rendez-vous'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
