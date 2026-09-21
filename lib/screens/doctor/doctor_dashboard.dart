import 'package:flutter/material.dart';

import 'doctor_profile.dart';
import 'doctor_appointments_screen.dart';

import '../shared/medicines_screen.dart';
import '../shared/orders_screen.dart';

import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';
import '../payment/payment_screen.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Doctor Dashboard",
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
              ],
            ),

            const SizedBox(height: 25),

            // ==========================================================
            // WELCOME HERO
            // ==========================================================

            _welcomeCard(context),

            const SizedBox(height: 30),

            // ==========================================================
            // OVERVIEW
            // ==========================================================

            const Text(
              "Overview",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              "Your healthcare activity at a glance",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 18),

            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;

                double cardWidth;

                if (width >= 1200) {
                  cardWidth = 250;
                } else if (width >= 800) {
                  cardWidth = 220;
                } else {
                  cardWidth = width;
                }

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _overviewCard(
                      width: cardWidth,
                      title: "Medicines",
                      value: "120",
                      subtitle: "Products available",
                      icon: Icons.medication_outlined,
                      iconColor: AppColors.primary,
                      iconBackground: AppColors.lightTeal,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MedicinesScreen(),
                          ),
                        );
                      },
                    ),
                    _overviewCard(
                      width: cardWidth,
                      title: "Appointments",
                      value: "4",
                      subtitle: "Upcoming meetings",
                      icon: Icons.calendar_month_outlined,
                      iconColor: Colors.blue,
                      iconBackground: const Color(0xffEAF3FF),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const DoctorAppointmentsScreen(),
                          ),
                        );
                      },
                    ),
                    _overviewCard(
                      width: cardWidth,
                      title: "My Orders",
                      value: "8",
                      subtitle: "Medicine orders",
                      icon: Icons.shopping_bag_outlined,
                      iconColor: Colors.orange,
                      iconBackground: const Color(0xfffff3d9),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OrdersScreen(),
                          ),
                        );
                      },
                    ),
                    _overviewCard(
                      width: cardWidth,
                      title: "Today's Visits",
                      value: "3",
                      subtitle: "Scheduled today",
                      icon: Icons.location_on_outlined,
                      iconColor: Colors.purple,
                      iconBackground: const Color(0xffF2EAFE),
                      onTap: () {
                        _showComingSoon(context, "Today's Visits");
                      },
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 35),

            // ==========================================================
            // QUICK ACCESS
            // ==========================================================

            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Access",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Go directly to your frequently used sections",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;

                double cardWidth;

                if (width >= 1200) {
                  cardWidth = 250;
                } else if (width >= 800) {
                  cardWidth = 220;
                } else {
                  cardWidth = width;
                }

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    _quickAccessCard(
                      width: cardWidth,
                      title: "Medicines",
                      subtitle: "Browse products",
                      icon: Icons.medication_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const MedicinesScreen(),
                          ),
                        );
                      },
                    ),
                    _quickAccessCard(
                      width: cardWidth,
                      title: "My Profile",
                      subtitle: "Manage profile",
                      icon: Icons.person_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const DoctorProfile(),
                          ),
                        );
                      },
                    ),
                    _quickAccessCard(
                      width: cardWidth,
                      title: "Appointments",
                      subtitle: "Manage appointments",
                      icon: Icons.calendar_month_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const DoctorAppointmentsScreen(),
                          ),
                        );
                      },
                    ),
                    _quickAccessCard(
                      width: cardWidth,
                      title: "My Orders",
                      subtitle: "Track medicine orders",
                      icon: Icons.shopping_cart_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OrdersScreen(),
                          ),
                        );
                      },
                    ),
                    _quickAccessCard(
                      width: cardWidth,
                      title: "Make Payment",
                      subtitle: "Pay for medicine orders",
                      icon: Icons.payment_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentScreen(
                              amount: 500,
                              customerName: "Sathiyaraj",
                              customerEmail: "test@example.com",
                            ),
                          ),
                        );
                      },
                    ),
                    _quickAccessCard(
                      width: cardWidth,
                      title: "Companies",
                      subtitle: "Pharma companies",
                      icon: Icons.business_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const MedicinesScreen(),
                          ),
                        );
                      },
                    ),
                    _quickAccessCard(
                      width: cardWidth,
                      title: "Dashboard",
                      subtitle: "Current overview",
                      icon: Icons.dashboard_outlined,
                      onTap: () {},
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 35),

            // ==========================================================
            // TODAY + ORDERS
            // ==========================================================

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 950) {
                  return Column(
                    children: [
                      _todaySchedule(context),
                      const SizedBox(height: 22),
                      _recentOrders(context),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _todaySchedule(context),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: _recentOrders(context),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 35),

            // ==========================================================
            // RECOMMENDED MEDICINES
            // ==========================================================

            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommended Medicines",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Medicines related to your specialty",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const MedicinesScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;

                double cardWidth;

                if (width >= 1200) {
                  cardWidth = 250;
                } else if (width >= 800) {
                  cardWidth = 220;
                } else {
                  cardWidth = width;
                }

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _medicineCard(
                      context,
                      cardWidth,
                      "Slew",
                      "Example Molecule A",
                      "1 mg / 2 mg / 5 mg",
                    ),
                    _medicineCard(
                      context,
                      cardWidth,
                      "CardioSafe",
                      "Example Molecule B",
                      "5 mg / 10 mg",
                    ),
                    _medicineCard(
                      context,
                      cardWidth,
                      "HeartCare",
                      "Example Molecule C",
                      "10 mg / 20 mg",
                    ),
                    _medicineCard(
                      context,
                      cardWidth,
                      "CardioMax",
                      "Example Molecule D",
                      "20 mg / 40 mg",
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // WELCOME CARD
  // ================================================================

  Widget _welcomeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0E746B),
            Color(0xff15978D),
            Color(0xff20AA9E),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeContent(),
                const SizedBox(height: 24),
                _profileButton(context),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _welcomeContent(),
              ),
              const SizedBox(width: 20),
              _profileButton(context),
            ],
          );
        },
      ),
    );
  }

  // ================================================================
  // WELCOME CONTENT
  // ================================================================

  Widget _welcomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.16),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.medical_services_outlined,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "PharmaCare",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        const Text(
          "Good Morning, Doctor 👋",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Welcome back. Manage your medicines, appointments and orders from one place.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 18),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _heroChip(
              Icons.local_hospital_outlined,
              "ABC Hospital",
            ),
            _heroChip(
              Icons.medical_information_outlined,
              "Cardiology",
            ),
            _heroChip(
              Icons.location_on_outlined,
              "Chennai",
            ),
          ],
        ),
      ],
    );
  }

  // ================================================================
  // HERO CHIP
  // ================================================================

  Widget _heroChip(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white70,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PROFILE BUTTON
  // ================================================================

  Widget _profileButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DoctorProfile(),
          ),
        );
      },
      icon: const Icon(
        Icons.person_outline,
        color: Colors.white,
      ),
      label: const Text(
        "View Profile",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Colors.white.withOpacity(0.45),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // ================================================================
  // OVERVIEW CARD
  // ================================================================

  Widget _overviewCard({
    required double width,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 26,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // QUICK ACCESS CARD
  // ================================================================

  Widget _quickAccessCard({
    required double width,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
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
                  color: AppColors.lightTeal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // TODAY'S SCHEDULE
  // ================================================================

  Widget _todaySchedule(BuildContext context) {
    return _sectionCard(
      title: "Today's Schedule",
      icon: Icons.calendar_today_outlined,
      actionText: "View All",
      onAction: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const DoctorAppointmentsScreen(),
          ),
        );
      },
      child: Column(
        children: [
          _scheduleItem(
            time: "10:30 AM",
            company: "ABC Pharma",
            description: "Medicine Presentation",
            location: "Chennai",
            status: "Confirmed",
          ),

          _scheduleItem(
            time: "02:30 PM",
            company: "XYZ Pharmaceuticals",
            description: "Product Discussion",
            location: "Coimbatore",
            status: "Pending",
          ),

          _scheduleItem(
            time: "04:00 PM",
            company: "Premier Therapeutics",
            description: "Medicine Review",
            location: "Chennai",
            status: "Confirmed",
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SCHEDULE ITEM
  // ================================================================

  Widget _scheduleItem({
    required String time,
    required String company,
    required String description,
    required String location,
    required String status,
  }) {
    final bool isConfirmed = status == "Confirmed";

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffFAFCFB),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  company,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isConfirmed
                  ? const Color(0xffEAF8EF)
                  : const Color(0xfffff3cd),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isConfirmed
                    ? Colors.green
                    : Colors.orange,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // RECENT ORDERS
  // ================================================================

  Widget _recentOrders(BuildContext context) {
    return _sectionCard(
      title: "Recent Orders",
      icon: Icons.shopping_bag_outlined,
      actionText: "View All",
      onAction: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const OrdersScreen(),
          ),
        );
      },
      child: Column(
        children: [
          _orderItem(
            "PC-102451",
            "Slew 2 mg",
            "Delivered",
          ),

          _orderItem(
            "PC-102188",
            "CardioSafe 10 mg",
            "Delivered",
          ),

          _orderItem(
            "PC-101947",
            "Diabetix 500 mg",
            "Processing",
          ),
        ],
      ),
    );
  }

  // ================================================================
  // ORDER ITEM
  // ================================================================

  Widget _orderItem(
      String id,
      String medicine,
      String status,
      ) {
    final bool delivered = status == "Delivered";

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffFAFCFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: AppColors.primary,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  medicine,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  id,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Text(
            status,
            style: TextStyle(
              color: delivered
                  ? Colors.green
                  : Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SECTION CARD
  // ================================================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required String actionText,
    required VoidCallback onAction,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextButton(
                onPressed: onAction,
                child: Text(
                  actionText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          child,
        ],
      ),
    );
  }

  // ================================================================
  // MEDICINE CARD
  // ================================================================

  Widget _medicineCard(
      BuildContext context,
      double width,
      String name,
      String molecule,
      String strength,
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MedicinesScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.lightTeal,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.medication_outlined,
                    color: AppColors.primary,
                    size: 27,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: Colors.grey,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              molecule,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF4F8F7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                strength,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // COMING SOON MESSAGE
  // ================================================================

  void _showComingSoon(
      BuildContext context,
      String feature,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$feature feature is ready for integration.",
        ),
      ),
    );
  }
}
