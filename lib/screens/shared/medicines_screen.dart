import 'package:flutter/material.dart';
import '../../widgets/web_layout.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/breadcrumb.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Medicines",
      menu: "doctor",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb
            const Breadcrumb(
              items: [
                BreadcrumbItem(
                  title: "Dashboard",
                ),
                BreadcrumbItem(
                  title: "Medicines",
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Medicines for Cardiology",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Browse medicines related to your specialty",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // SEARCH
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search company or location",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchText = "";
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                if ("ABC Pharmaceuticals"
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                    "Mumbai, Maharashtra"
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                  companyCard(
                    context,
                    "ABC Pharmaceuticals",
                    "Mumbai, Maharashtra",
                    "42 Medicines",
                  ),

                if ("XYZ Pharma"
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                    "Hyderabad, Telangana"
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                  companyCard(
                    context,
                    "XYZ Pharma",
                    "Hyderabad, Telangana",
                    "30 Medicines",
                  ),

                if ("HealthCare Labs"
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                    "Chennai, Tamil Nadu"
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                  companyCard(
                    context,
                    "HealthCare Labs",
                    "Chennai, Tamil Nadu",
                    "25 Medicines",
                  ),

                if ("Premier Therapeutics"
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                    "Bengaluru, Karnataka"
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                  companyCard(
                    context,
                    "Premier Therapeutics",
                    "Bengaluru, Karnataka",
                    "38 Medicines",
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}