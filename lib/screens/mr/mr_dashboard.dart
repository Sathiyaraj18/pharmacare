import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'mr_doctors_screen.dart';
import 'selected_doctors_screen.dart';
import 'mr_appointments_screen.dart';
import 'mr_reviews_screen.dart';

import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';
import '../../widgets/common_widgets.dart';
import '../../theme/app_colors.dart';

class MRDashboard extends StatefulWidget {
  const MRDashboard({super.key});

  @override
  State<MRDashboard> createState() => _MRDashboardState();
}

class _MRDashboardState extends State<MRDashboard> {
  String mrName = "MR";

  @override
  void initState() {
    super.initState();
    loadMRName();
  }

  // ============================================================
  // LOAD MR NAME FROM FIREBASE
  // ============================================================

  Future<void> loadMRName() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint("MR DASHBOARD: No logged-in user");
        return;
      }

      debugPrint(
        "MR DASHBOARD: Logged in UID = ${user.uid}",
      );

      String name = user.displayName ?? "";

      debugPrint(
        "MR DASHBOARD: Auth displayName = ${user.displayName}",
      );

      debugPrint(
        "MR DASHBOARD: Auth email = ${user.email}",
      );

      // Get MR profile from Firestore
      final DocumentSnapshot<Map<String, dynamic>> doc =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final Map<String, dynamic>? data = doc.data();

        debugPrint(
          "MR DASHBOARD: Firestore data = $data",
        );

        final String firestoreName =
            data?["name"]?.toString() ?? "";

        if (firestoreName.isNotEmpty) {
          name = firestoreName;
        }

        debugPrint(
          "MR DASHBOARD: MR name = $name",
        );

        debugPrint(
          "MR DASHBOARD: Email = ${data?["email"]}",
        );

        debugPrint(
          "MR DASHBOARD: Role = ${data?["role"]}",
        );
      }

      if (!mounted) {
        return;
      }

      setState(() {
        mrName = name.isNotEmpty ? name : "MR";
      });
    } catch (e) {
      debugPrint(
        "MR DASHBOARD: Error loading MR name = $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "MR Dashboard",
      menu: "mr",

      breadcrumbItems: const [
        BreadcrumbItem(
          title: "Dashboard",
        ),
      ],

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // WELCOME HEADER
            // ==================================================

            _welcomeSection(context),

            const SizedBox(height: 30),

            // ==================================================
            // OVERVIEW CARDS
            // ==================================================

            const Text(
              "Overview",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;

                if (width < 700) {
                  return Column(
                    children: [
                      dashboardCard(
                        "Doctors",
                        "125",
                        Icons.people_outline,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const MRDoctorsScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

                      dashboardCard(
                        "Selected Doctors",
                        "8 / 10",
                        Icons.check_circle_outline,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const SelectedDoctorsScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

                      dashboardCard(
                        "Today's Visits",
                        "5",
                        Icons.calendar_today_outlined,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const MRAppointmentsScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

                      dashboardCard(
                        "Reviews",
                        "3 Pending",
                        Icons.star_outline,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const MRReviewsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }

                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    dashboardCard(
                      "Doctors",
                      "125",
                      Icons.people_outline,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const MRDoctorsScreen(),
                          ),
                        );
                      },
                    ),

                    dashboardCard(
                      "Selected Doctors",
                      "8 / 10",
                      Icons.check_circle_outline,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const SelectedDoctorsScreen(),
                          ),
                        );
                      },
                    ),

                    dashboardCard(
                      "Today's Visits",
                      "5",
                      Icons.calendar_today_outlined,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const MRAppointmentsScreen(),
                          ),
                        );
                      },
                    ),

                    dashboardCard(
                      "Reviews",
                      "3 Pending",
                      Icons.star_outline,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const MRReviewsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            // ==================================================
            // QUICK ACCESS
            // ==================================================

            const Text(
              "Quick Access",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            LayoutBuilder(
              builder: (context, constraints) {
                final bool small =
                    constraints.maxWidth < 700;

                final List<Widget> items = [
                  quickAccessCard(
                    context,
                    "Doctors",
                    "Manage doctors",
                    Icons.people_alt_outlined,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const MRDoctorsScreen(),
                        ),
                      );
                    },
                  ),

                  quickAccessCard(
                    context,
                    "Selected Doctors",
                    "View selected doctors",
                    Icons.person_add_alt_1_outlined,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const SelectedDoctorsScreen(),
                        ),
                      );
                    },
                  ),

                  quickAccessCard(
                    context,
                    "Appointments",
                    "Manage visits",
                    Icons.calendar_month_outlined,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const MRAppointmentsScreen(),
                        ),
                      );
                    },
                  ),

                  quickAccessCard(
                    context,
                    "Reviews",
                    "Check pending reviews",
                    Icons.rate_review_outlined,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const MRReviewsScreen(),
                        ),
                      );
                    },
                  ),
                ];

                if (small) {
                  return Column(
                    children: [
                      for (
                      int i = 0;
                      i < items.length;
                      i++
                      ) ...[
                        items[i],
                        if (i != items.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  );
                }

                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: items,
                );
              },
            ),

            const SizedBox(height: 40),

            // ==================================================
            // TODAY'S SCHEDULE
            // ==================================================

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Today's Schedule",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const MRAppointmentsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            visitCard(
              "Dr. Kumar",
              "Cardiology • ABC Hospital",
              "10:00 AM",
              context,
            ),

            visitCard(
              "Dr. Ravi",
              "Cardiology • City Hospital",
              "11:30 AM",
              context,
            ),

            visitCard(
              "Dr. Arun",
              "Cardiology • Apollo Hospital",
              "02:00 PM",
              context,
            ),

            const SizedBox(height: 25),

            // ==================================================
            // FIELD ACTIVITY
            // ==================================================

            const Text(
              "Today's Field Activity",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _fieldActivity(),

            const SizedBox(height: 40),

            // ==================================================
            // RECENT REVIEWS
            // ==================================================

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Recent Reviews",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const MRReviewsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            _reviewCard(
              "Dr. Kumar",
              "Medicine presentation completed",
              "Today, 10:20 AM",
              5,
            ),

            _reviewCard(
              "Dr. Ravi",
              "Product discussion completed",
              "Today, 12:15 PM",
              4,
            ),

            _reviewCard(
              "Dr. Arun",
              "Follow-up required",
              "Yesterday",
              3,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WELCOME SECTION
  // ============================================================

  Widget _welcomeSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool small =
              constraints.maxWidth < 700;

          if (small) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                _welcomeIcon(),

                const SizedBox(height: 20),

                _welcomeText(),

                const SizedBox(height: 20),

                _activeBadge(),
              ],
            );
          }

          return Row(
            children: [
              _welcomeIcon(),

              const SizedBox(width: 20),

              Expanded(
                child: _welcomeText(),
              ),

              const SizedBox(width: 20),

              _activeBadge(),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // WELCOME ICON
  // ============================================================

  Widget _welcomeIcon() {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(21),
      ),
      child: const Icon(
        Icons.medical_services_outlined,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  // ============================================================
  // WELCOME TEXT
  // ============================================================

  Widget _welcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good Morning, $mrName 👋",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Cardiology Division • ABC Pharma",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 14),

        const Text(
          "Manage your doctors, appointments and field activities",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ACTIVE BADGE
  // ============================================================

  Widget _activeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 9,
            width: 9,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            "Active",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FIELD ACTIVITY
  // ============================================================

  Widget _fieldActivity() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _activityRow(
            Icons.people_outline,
            "Doctors Visited",
            "4 / 5",
            "80%",
          ),

          const Divider(height: 28),

          _activityRow(
            Icons.location_on_outlined,
            "Locations Covered",
            "3",
            "Today",
          ),

          const Divider(height: 28),

          _activityRow(
            Icons.medication_outlined,
            "Presentations",
            "6",
            "Completed",
          ),

          const Divider(height: 28),

          _activityRow(
            Icons.assignment_outlined,
            "Pending Follow-ups",
            "3",
            "Pending",
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIVITY ROW
  // ============================================================

  Widget _activityRow(
      IconData icon,
      String title,
      String value,
      String subtitle,
      ) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.lightTeal,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(width: 8),

        Text(
          value,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(width: 8),

        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // REVIEW CARD
  // ============================================================

  Widget _reviewCard(
      String doctor,
      String description,
      String time,
      int rating,
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool small =
              constraints.maxWidth < 550;

          if (small) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.lightTeal,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.rate_review_outlined,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  description,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: List.generate(
                    5,
                        (index) => Icon(
                      index < rating
                          ? Icons.star
                          : Icons.star_border,
                      size: 17,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.rate_review_outlined,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < rating
                        ? Icons.star
                        : Icons.star_border,
                    size: 17,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}