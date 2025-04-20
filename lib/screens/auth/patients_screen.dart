import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Patients')),
      body: ListView.builder(
        itemCount: 10,  // Par exemple, 10 patients
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Patient ${index + 1}'),
            subtitle: Text('Dernière visite: 12/03/2025'),
            onTap: () {
              // Naviguer vers les détails du patient
            },
          );
        },
      ),
    );
  }
}
