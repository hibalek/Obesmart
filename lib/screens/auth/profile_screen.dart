import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui'; // Pour le flou

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, File? profileImage});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Dr. Mohamed B.';
  String _speciality = 'Spécialiste en cardiologie';
  File? _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();

  List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Patient 1',
      'rating': 4,
      'comment': 'Très bon médecin !',
      'image': 'assets/patient1.jpg',
      'phone': '1234567890',
      'analyses': 'Test sanguin: Normal, ECG: Normal',
      'medicalRecord': 'Aucun antécédent grave',
    },
    {
      'name': 'Patient 2',
      'rating': 5,
      'comment': 'Service excellent.',
      'image': 'assets/patient2.jpg',
      'phone': '1234567891',
      'analyses': 'Test sanguin: OK, ECG: Normal',
      'medicalRecord': 'Antécédent de diabète',
    },
    {
      'name': 'Patient 3',
      'rating': 3,
      'comment': 'Très satisfaisant.',
      'image': 'assets/patient3.jpg',
      'phone': '1234567892',
      'analyses': 'Test sanguin: Anomalie, ECG: Normal',
      'medicalRecord': 'Aucun antécédent grave',
    },
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = _name;
    _specialityController.text = _speciality;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    setState(() {
      _name = _nameController.text;
      _speciality = _specialityController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil mis à jour avec succès")),
    );
  }

  Future<void> _sendMessage(String phoneNumber) async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d’ouvrir WhatsApp pour $phoneNumber';
    }
  }

  void _viewPatientDetails(Map<String, dynamic> patient) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Profil de ${patient['name']}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Affichage de la photo de profil du patient
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(patient['image']),
                  ),
                ),
                const SizedBox(height: 15),
                // Nom du patient
                Text(
                  'Nom : ${patient['name']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                // Commentaire du patient
                Text(
                  'Commentaire : ${patient['comment']}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                // Affichage de la note du patient
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < patient['rating'] ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    );
                  }),
                ),
                const SizedBox(height: 10),
                // Analyses médicales
                Text(
                  'Analyses Médicales : ${patient['analyses']}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                // Dossier médical
                Text(
                  'Dossier Médical : ${patient['medicalRecord']}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.blue.shade300],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -100,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.yellow.shade100, Colors.yellow.shade200],
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : const AssetImage('lib/logo.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _specialityController,
                  decoration: InputDecoration(
                    labelText: 'Spécialité / Description',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('Enregistrer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Avis des patients',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ..._reviews.map((review) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(review['image']),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < review['rating'] ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                      size: 18,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  review['comment'],
                                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.message, color: Colors.blue),
                            onPressed: () => _sendMessage(review['phone']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.visibility, color: Colors.green),
                            onPressed: () => _viewPatientDetails(review),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
