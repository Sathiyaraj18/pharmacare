import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hospitalController =
  TextEditingController();

  String specialty = "Cardiology";

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    loadDoctorProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    hospitalController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOAD DOCTOR PROFILE
  // ============================================================

  Future<void> loadDoctorProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      debugPrint("PROFILE: Logged in UID = ${user.uid}");

      final DocumentSnapshot<Map<String, dynamic>> document =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (document.exists) {
        final data = document.data();

        debugPrint("PROFILE: Firestore data = $data");

        // Name from signup
        nameController.text =
            (data?['name'] ?? user.displayName ?? "").toString();

        // Hospital
        hospitalController.text =
            (data?['hospital'] ?? "ABC Hospital").toString();

        // Specialty
        final savedSpecialty =
        (data?['specialty'] ?? "Cardiology").toString();

        if ([
          "Cardiology",
          "Orthopedics",
          "Diabetology",
          "Neurology",
        ].contains(savedSpecialty)) {
          specialty = savedSpecialty;
        }
      } else {
        // Firestore document does not exist
        nameController.text = user.displayName ?? "";
        hospitalController.text = "ABC Hospital";

        debugPrint("PROFILE: Firestore user document not found.");
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("PROFILE LOAD ERROR: $e");

      if (mounted) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to load profile: $e",
            ),
          ),
        );
      }
    }
  }

  // ============================================================
  // SAVE PROFILE
  // ============================================================

  Future<void> saveProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is not logged in."),
        ),
      );
      return;
    }

    final String name = nameController.text.trim();
    final String hospital = hospitalController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your name."),
        ),
      );
      return;
    }

    try {
      setState(() {
        isSaving = true;
      });

      debugPrint("PROFILE SAVE: Updating Firestore...");

      // Save name + other profile information
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(
        {
          'name': name,
          'email': user.email,
          'role': 'doctor',
          'uid': user.uid,
          'hospital': hospital,
          'specialty': specialty,
        },
        SetOptions(merge: true),
      );

      debugPrint("PROFILE SAVE: Firestore SUCCESS");

      // Also update Firebase Authentication display name
      await user.updateDisplayName(name);

      debugPrint("PROFILE SAVE: Firebase Auth displayName SUCCESS");

      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Profile updated successfully.",
          ),
        ),
      );
    } catch (e) {
      debugPrint("PROFILE SAVE ERROR: $e");

      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to save profile: $e",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Doctor Profile",
      menu: "doctor",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================================
            // BREADCRUMB
            // ==========================================================

            const Breadcrumb(
              items: [
                BreadcrumbItem(
                  title: "Dashboard",
                ),
                BreadcrumbItem(
                  title: "Profile",
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==========================================================
            // PROFILE CONTAINER
            // ==========================================================

            Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: isLoading
                  ? const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Professional Information",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // DOCTOR NAME
                  // ==================================================

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Doctor Name",
                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ==================================================
                  // HOSPITAL
                  // ==================================================

                  TextField(
                    controller: hospitalController,
                    decoration: InputDecoration(
                      labelText: "Hospital / Clinic",
                      prefixIcon: const Icon(
                        Icons.local_hospital_outlined,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // SPECIALIZATION
                  // ==================================================

                  const Text(
                    "Specialization",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: specialty,
                    items: const [
                      DropdownMenuItem(
                        value: "Cardiology",
                        child: Text("Cardiology"),
                      ),
                      DropdownMenuItem(
                        value: "Orthopedics",
                        child: Text("Orthopedics"),
                      ),
                      DropdownMenuItem(
                        value: "Diabetology",
                        child: Text("Diabetology"),
                      ),
                      DropdownMenuItem(
                        value: "Neurology",
                        child: Text("Neurology"),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        specialty = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // VISITING HOURS
                  // ==================================================

                  const Text(
                    "Clinic Visiting Hours",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  visitingHour("Monday"),
                  visitingHour("Tuesday"),
                  visitingHour("Wednesday"),
                  visitingHour("Thursday"),
                  visitingHour("Friday"),

                  const SizedBox(height: 20),

                  // ==================================================
                  // SAVE BUTTON
                  // ==================================================

                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: isSaving
                          ? null
                          : saveProfile,
                      icon: isSaving
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(
                        Icons.save_outlined,
                      ),
                      label: Text(
                        isSaving
                            ? "Saving..."
                            : "Save Profile",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // VISITING HOURS
  // ============================================================

  Widget visitingHour(String day) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.access_time,
        ),
        title: Text(day),
        subtitle: const Text(
          "10:00 AM - 1:00 PM    |    2:00 PM - 6:00 PM",
        ),
        trailing: Switch(
          value: true,
          onChanged: (_) {},
        ),
      ),
    );
  }
}