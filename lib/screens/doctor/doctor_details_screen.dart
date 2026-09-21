import 'package:flutter/material.dart';
import '../../widgets/breadcrumb.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        title: const Text("Doctor Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

// Breadcrumb
            Breadcrumb(
              items: [
                BreadcrumbItem(
                  title: "Home",
                  onTap: () {
                    print("Home clicked");
                  },
                ),

                BreadcrumbItem(
                  title: "Doctors",
                  onTap: () {
                    print("Doctors clicked");
                  },
                ),

                const BreadcrumbItem(
                  title: "Doctor Details",
                ),
              ],
            ),

            const SizedBox(height: 30),

// Page title
            const Text(
              "Doctor Details",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Doctor information will appear here",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
