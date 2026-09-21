import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';

class MRReviewsScreen extends StatelessWidget {
  const MRReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Doctor Reviews",
      menu: "mr",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Doctor Feedback",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            reviewTile("Dr. Kumar", 5, "Very useful medicine presentation."),
            reviewTile("Dr. Priya", 4, "Requested additional product information."),
            reviewTile("Dr. Ravi", 5, "Presentation completed successfully."),
          ],
        ),
      ),
    );
  }

  Widget reviewTile(String doctor, int rating, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundColor: AppColors.lightTeal,
          child: Icon(Icons.star_outline, color: AppColors.primary),
        ),
        title: Text(doctor,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                5,
                    (i) => Icon(
                  i < rating ? Icons.star : Icons.star_border,
                  size: 17,
                  color: Colors.amber,
                ),
              ),
            ),
            Text(text),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}

