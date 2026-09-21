import 'package:flutter/material.dart';
import '../shared/appointment_screen.dart';
import 'mr_doctors_screen.dart';
import '../../widgets/web_layout.dart';
import 'mr_dashboard.dart';
import '../../widgets/breadcrumb.dart';

class SelectedDoctorsScreen extends StatelessWidget {
  final List<String> doctors;

  const SelectedDoctorsScreen({
    super.key,
    this.doctors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Selected Doctors",
      menu: "mr",
      breadcrumbItems: [
        BreadcrumbItem(
          title: "Dashboard",
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MRDashboard(),
              ),
            );
          },
        ),
        BreadcrumbItem(
          title: "Doctors",
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MRDoctorsScreen(),
              ),
            );
          },
        ),
        const BreadcrumbItem(
          title: "Selected Doctors",
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Selected Doctors",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (doctors.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 70,
                        color: Colors.grey.shade400,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "No doctors selected",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Select 7 to 10 doctors from the Doctors page.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MRDoctorsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.people_outline),
                        label: const Text("Select Doctors"),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),

                      child: ListTile(
                        contentPadding:
                        const EdgeInsets.all(15),

                        leading: CircleAvatar(
                          child: Text(
                            "${index + 1}",
                          ),
                        ),

                        title: Text(
                          doctors[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: const Text(
                          "Cardiology • ABC Hospital",
                        ),

                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AppointmentScreen(
                                      doctor: doctors[index],
                                    ),
                              ),
                            );
                          },
                          child: const Text(
                            "Appointment",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

