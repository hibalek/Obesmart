import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Map<String, String>> _appointments = [
    {
      "time": "10:00",
      "patient": "Ahmed Bouzid",
      "note": "Consultation générale",
      "id": "1",
      "date": "12/04/2025",
    },
    {
      "time": "11:30",
      "patient": "Lina Amrani",
      "note": "Résultats de prise de sang",
      "id": "2",
      "date": "12/04/2025",
    },
    {
      "time": "14:00",
      "patient": "Sami Berrah",
      "note": "Contrôle de tension",
      "id": "3",
      "date": "12/04/2024", // RDV dans le passé (historique)
    },
  ];

  final Map<String, Map<String, String>> patientDetails = {
    '1': {
      'name': 'Ahmed Bouzid',
      'age': '45',
      'diagnosis': 'Hypertension',
      'medicalHistory': 'Aucune complication majeure',
      'image': 'https://i.pravatar.cc/150?img=1'
    },
    '2': {
      'name': 'Lina Amrani',
      'age': '30',
      'diagnosis': 'Asthme',
      'medicalHistory': 'Allergies saisonnières',
      'image': 'https://i.pravatar.cc/150?img=2'
    },
    '3': {
      'name': 'Sami Berrah',
      'age': '60',
      'diagnosis': 'Diabète',
      'medicalHistory': 'Antécédent familial de diabète',
      'image': 'https://i.pravatar.cc/150?img=3'
    },
  };

  void _viewPatientProfile(BuildContext context, String patientId) {
    final patient = patientDetails[patientId];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(patient!['image']!),
                ),
                const SizedBox(height: 10),
                Text('Profil de ${patient['name']}'),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nom: ${patient['name']}'),
              Text('Âge: ${patient['age']}'),
              Text('Diagnostic: ${patient['diagnosis']}'),
              Text('Antécédents médicaux: ${patient['medicalHistory']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _rescheduleAppointment(BuildContext context, String appointmentTime) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Reporter le rendez-vous"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Rendez-vous actuel: $appointmentTime"),
              const SizedBox(height: 10),
              const Text("Nouvelle heure (ex: 15:00):"),
              const TextField(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _showPatientHistory(BuildContext context, String patientId) {
    final patient = patientDetails[patientId];
    final history = getAppointmentHistory().where((appt) => appt['id'] == patientId).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Historique - ${patient?['name']}"),
          content: history.isEmpty
              ? const Text("Aucun rendez-vous passé.")
              : SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final appt = history[index];
                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text("${appt['date']} à ${appt['time']}"),
                        subtitle: Text(appt['note']!),
                      );
                    },
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, String>> getAppointmentsForDay(DateTime? day) {
    final selectedDateStr = "${day?.day.toString().padLeft(2, '0')}/${day?.month.toString().padLeft(2, '0')}/${day?.year}";
    return _appointments.where((appt) => appt['date'] == selectedDateStr).toList();
  }

  List<Map<String, String>> getAppointmentHistory() {
    final now = DateTime.now();
    return _appointments.where((appt) {
      final parts = appt['date']!.split('/');
      final date = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      return date.isBefore(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final todayAppointments = getAppointmentsForDay(_selectedDay ?? _focusedDay);
    final pastAppointments = getAppointmentHistory();

    return Stack(
      children: [
        Positioned(
          top: -80,
          left: -50,
          child: BlurredCircle(
            size: 220,
            color: Colors.blue.withOpacity(0.35),
            blurSigma: 620, // 👈 plus de flou ici
          ),
        ),
        Positioned(
          bottom: -50,
          right: -40,
          child: BlurredCircle(
            size: 170,
            color: Colors.yellow.withOpacity(0.35),
            blurSigma: 120, // 👈 plus de flou ici aussi
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Rendez-vous du jour",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...todayAppointments.map((appointment) => buildAppointmentCard(appointment)),
                    if (pastAppointments.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Historique des rendez-vous",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...pastAppointments.map((appointment) => buildAppointmentCard(appointment)),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAppointmentCard(Map<String, String> appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.access_time, color: Colors.blue),
        title: Text("${appointment['time']} - ${appointment['patient']}"),
        subtitle: Text("Note: ${appointment['note']} - Date: ${appointment['date']}"),
        trailing: Wrap(
          spacing: 12,
          children: [
            IconButton(
              icon: const Icon(Icons.visibility),
              color: Colors.green,
              onPressed: () => _viewPatientProfile(context, appointment['id']!),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.orange,
              onPressed: () => _rescheduleAppointment(context, appointment['time']!),
            ),
            IconButton(
              icon: const Icon(Icons.history),
              color: Colors.blueGrey,
              onPressed: () => _showPatientHistory(context, appointment['id']!),
            ),
          ],
        ),
      ),
    );
  }
}

class BlurredCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double blurSigma;

  const BlurredCircle({
    super.key,
    required this.size,
    required this.color,
    this.blurSigma = 70,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
