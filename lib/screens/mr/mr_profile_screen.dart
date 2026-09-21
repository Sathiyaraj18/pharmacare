import 'package:flutter/material.dart';
import '../../widgets/web_layout.dart';

class MRProfileScreen extends StatefulWidget {
  const MRProfileScreen({super.key});

  @override
  State<MRProfileScreen> createState() => _MRProfileScreenState();
}

class _MRProfileScreenState extends State<MRProfileScreen> {
  String selectedDivision = "Cardiology";

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "MR Profile",
      menu: "mr",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =====================================================
                // PROFILE HEADER
                // =====================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // PROFILE IMAGE
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.teal.shade700,
                        ),
                      ),

                      const SizedBox(width: 22),

                      // NAME + DESIGNATION
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Raj Kumar",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Medical Representative",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Chennai, Tamil Nadu",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // STATUS
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              "Active",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // =====================================================
                // PERSONAL INFORMATION
                // =====================================================

                _sectionCard(
                  title: "Personal Information",
                  icon: Icons.person_outline,
                  children: [
                    _responsiveRow(
                      context,
                      [
                        _profileField(
                          label: "Full Name",
                          icon: Icons.person_outline,
                          value: "Raj Kumar",
                        ),
                        _profileField(
                          label: "Employee ID",
                          icon: Icons.badge_outlined,
                          value: "MR-10245",
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _responsiveRow(
                      context,
                      [
                        _profileField(
                          label: "Phone Number",
                          icon: Icons.phone_outlined,
                          value: "+91 98765 43210",
                        ),
                        _profileField(
                          label: "Email Address",
                          icon: Icons.email_outlined,
                          value: "raj.kumar@pharmacare.com",
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // =====================================================
                // COMPANY INFORMATION
                // =====================================================

                _sectionCard(
                  title: "Company Information",
                  icon: Icons.business_outlined,
                  children: [
                    _responsiveRow(
                      context,
                      [
                        _profileField(
                          label: "Company Name",
                          icon: Icons.business_outlined,
                          value: "PharmaCare Ltd.",
                        ),
                        _profileField(
                          label: "Designation",
                          icon: Icons.work_outline,
                          value: "Medical Representative",
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _responsiveRow(
                      context,
                      [
                        _dropdownField(),
                        _profileField(
                          label: "Company Location",
                          icon: Icons.location_on_outlined,
                          value: "Chennai, Tamil Nadu",
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _responsiveRow(
                      context,
                      [
                        _profileField(
                          label: "Branch Office",
                          icon: Icons.location_city_outlined,
                          value: "Chennai South Branch",
                        ),
                        _profileField(
                          label: "Joining Date",
                          icon: Icons.calendar_month_outlined,
                          value: "24 February 2025",
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // =====================================================
                // TERRITORY & WORK INFORMATION
                // =====================================================

                _sectionCard(
                  title: "Work & Territory Information",
                  icon: Icons.map_outlined,
                  children: [
                    _responsiveRow(
                      context,
                      [
                        _profileField(
                          label: "Assigned Territory",
                          icon: Icons.location_searching_outlined,
                          value: "Chennai South",
                        ),
                        _profileField(
                          label: "Reporting Manager",
                          icon: Icons.supervisor_account_outlined,
                          value: "Arun Kumar",
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _responsiveRow(
                      context,
                      [
                        _profileField(
                          label: "Years of Experience",
                          icon: Icons.timeline_outlined,
                          value: "3 Years",
                        ),
                        _profileField(
                          label: "Therapy Focus",
                          icon: Icons.medical_services_outlined,
                          value: "Cardiology & Diabetes",
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // =====================================================
                // FIELD ACTIVITY
                // =====================================================

                _sectionCard(
                  title: "Field Activity",
                  icon: Icons.analytics_outlined,
                  children: [
                    _responsiveRow(
                      context,
                      [
                        _statCard(
                          title: "Assigned Doctors",
                          value: "48",
                          icon: Icons.people_outline,
                        ),
                        _statCard(
                          title: "Assigned Hospitals",
                          value: "12",
                          icon: Icons.local_hospital_outlined,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _responsiveRow(
                      context,
                      [
                        _statCard(
                          title: "Monthly Visit Target",
                          value: "120",
                          icon: Icons.flag_outlined,
                        ),
                        _statCard(
                          title: "Visits Completed",
                          value: "86",
                          icon: Icons.check_circle_outline,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // =====================================================
                // PROFILE SUMMARY
                // =====================================================

                _sectionCard(
                  title: "About Medical Representative",
                  icon: Icons.description_outlined,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xffF7FAF9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Responsible for managing assigned doctors and healthcare accounts, "
                            "conducting product presentations, maintaining customer relationships, "
                            "tracking field visits, and supporting medicine awareness activities "
                            "within the assigned territory.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // =====================================================
                // SAVE BUTTON
                // =====================================================

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Profile changes discarded.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                      label: const Text(
                        "Cancel",
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(120, 48),
                      ),
                    ),

                    const SizedBox(width: 12),

                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "MR profile saved successfully.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.save_outlined,
                      ),
                      label: const Text(
                        "Save Profile",
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 48),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // SECTION CARD
  // ===============================================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.teal.shade700,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          ...children,
        ],
      ),
    );
  }

  // ===============================================================
  // RESPONSIVE ROW
  // ===============================================================

  Widget _responsiveRow(
      BuildContext context,
      List<Widget> children,
      ) {
    if (MediaQuery.of(context).size.width < 700) {
      return Column(
        children: [
          ...children.map(
                (child) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: child,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < children.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: i == children.length - 1 ? 0 : 16,
              ),
              child: children[i],
            ),
          ),
      ],
    );
  }

  // ===============================================================
  // PROFILE FIELD
  // ===============================================================

  Widget _profileField({
    required String label,
    required IconData icon,
    required String value,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xffFAFCFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.teal,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // DIVISION DROPDOWN
  // ===============================================================

  Widget _dropdownField() {
    return DropdownButtonFormField<String>(
      value: selectedDivision,
      decoration: InputDecoration(
        labelText: "Division",
        prefixIcon: const Icon(
          Icons.medical_information_outlined,
        ),
        filled: true,
        fillColor: const Color(0xffFAFCFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: "Cardiology",
          child: Text("Cardiology"),
        ),
        DropdownMenuItem(
          value: "Diabetology",
          child: Text("Diabetology"),
        ),
        DropdownMenuItem(
          value: "Orthopedics",
          child: Text("Orthopedics"),
        ),
        DropdownMenuItem(
          value: "Neurology",
          child: Text("Neurology"),
        ),
        DropdownMenuItem(
          value: "General Medicine",
          child: Text("General Medicine"),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedDivision = value;
          });
        }
      },
    );
  }

  // ===============================================================
  // STAT CARD
  // ===============================================================

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffF7FAF9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.teal.shade700,
            ),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}