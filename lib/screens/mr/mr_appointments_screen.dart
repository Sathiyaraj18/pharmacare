import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';

class MRAppointmentsScreen extends StatefulWidget {
  const MRAppointmentsScreen({super.key});

  @override
  State<MRAppointmentsScreen> createState() =>
      _MRAppointmentsScreenState();
}

class _MRAppointmentsScreenState
    extends State<MRAppointmentsScreen> {
  final TextEditingController searchController =
  TextEditingController();

  String selectedFilter = "All";

  final List<Map<String, dynamic>> appointments = [
    {
      "doctor": "Dr. Kumar",
      "hospital": "ABC Hospital",
      "date": "12 Sep 2026",
      "time": "10:00 AM",
      "status": "Confirmed",
      "specialty": "Cardiologist",
      "phone": "+91 98765 43210",
      "color": Colors.blue,
    },
    {
      "doctor": "Dr. Arun",
      "hospital": "Apollo Hospital",
      "date": "12 Sep 2026",
      "time": "02:00 PM",
      "status": "Pending",
      "specialty": "Diabetologist",
      "phone": "+91 98765 12345",
      "color": Colors.orange,
    },
    {
      "doctor": "Dr. Priya",
      "hospital": "MIOT Hospital",
      "date": "13 Sep 2026",
      "time": "03:00 PM",
      "status": "Confirmed",
      "specialty": "Orthopedic",
      "phone": "+91 98765 67890",
      "color": Colors.purple,
    },
    {
      "doctor": "Dr. Rajesh",
      "hospital": "Kauvery Hospital",
      "date": "14 Sep 2026",
      "time": "11:30 AM",
      "status": "Pending",
      "specialty": "Neurologist",
      "phone": "+91 98765 98765",
      "color": Colors.teal,
    },
    {
      "doctor": "Dr. Meena",
      "hospital": "Fortis Hospital",
      "date": "15 Sep 2026",
      "time": "04:00 PM",
      "status": "Confirmed",
      "specialty": "General Physician",
      "phone": "+91 98765 55555",
      "color": Colors.indigo,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredAppointments {
    final search = searchController.text.toLowerCase();

    return appointments.where((appointment) {
      final doctor =
      appointment["doctor"].toString().toLowerCase();
      final hospital =
      appointment["hospital"].toString().toLowerCase();
      final specialty =
      appointment["specialty"].toString().toLowerCase();
      final status =
      appointment["status"].toString();

      final matchesSearch =
          doctor.contains(search) ||
              hospital.contains(search) ||
              specialty.contains(search);

      final matchesFilter =
          selectedFilter == "All" ||
              status == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get totalAppointments => appointments.length;

  int get confirmedAppointments {
    return appointments
        .where((item) => item["status"] == "Confirmed")
        .length;
  }

  int get pendingAppointments {
    return appointments
        .where((item) => item["status"] == "Pending")
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "MR Appointments",
      menu: "mr",
      child: Container(
        width: double.infinity,
        color: const Color(0xffF1F5F5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile =
                constraints.maxWidth < 700;

            final bool isTablet =
                constraints.maxWidth < 1000;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 30,
                  vertical: isMobile ? 18 : 28,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isMobile),
                    const SizedBox(height: 22),

                    _buildStatistics(
                      isMobile,
                      isTablet,
                    ),

                    const SizedBox(height: 22),

                    _buildToolbar(
                      isMobile,
                    ),

                    const SizedBox(height: 20),

                    _buildAppointmentList(
                      isMobile,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 28,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.14),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _headerIcon(),
          const SizedBox(height: 16),
          _headerText(),
        ],
      )
          : Row(
        children: [
          _headerIcon(),
          const SizedBox(width: 18),
          Expanded(
            child: _headerText(),
          ),
          _buildCalendarBadge(),
        ],
      ),
    );
  }

  Widget _headerIcon() {
    return Container(
      height: 58,
      width: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.calendar_month_rounded,
        color: AppColors.primary,
        size: 30,
      ),
    );
  }

  Widget _headerText() {
    return const Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          "FIELD VISIT MANAGEMENT",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Doctor Appointments",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Manage your doctor meetings and presentation schedules.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.event_available_outlined,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(height: 5),
          Text(
            "SCHEDULE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  Widget _buildStatistics(
      bool isMobile,
      bool isTablet,
      ) {
    if (isMobile) {
      return Column(
        children: [
          _statCard(
            title: "Total Appointments",
            value: totalAppointments.toString(),
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.primary,
          ),
          const SizedBox(height: 12),
          _statCard(
            title: "Confirmed",
            value: confirmedAppointments.toString(),
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
          ),
          const SizedBox(height: 12),
          _statCard(
            title: "Pending",
            value: pendingAppointments.toString(),
            icon: Icons.schedule_outlined,
            iconColor: Colors.orange,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _statCard(
            title: "Total Appointments",
            value: totalAppointments.toString(),
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _statCard(
            title: "Confirmed",
            value: confirmedAppointments.toString(),
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _statCard(
            title: "Pending",
            value: pendingAppointments.toString(),
            icon: Icons.schedule_outlined,
            iconColor: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
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
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH + FILTER
  // ============================================================

  Widget _buildToolbar(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: isMobile
          ? Column(
        children: [
          _buildSearchBox(),
          const SizedBox(height: 12),
          _buildFilter(),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: _buildSearchBox(),
          ),
          const SizedBox(width: 15),
          _buildFilter(),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      controller: searchController,
      onChanged: (_) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText:
        "Search doctor, hospital or specialty...",
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.primary,
        ),
        suffixIcon: searchController.text.isEmpty
            ? null
            : IconButton(
          onPressed: () {
            searchController.clear();
            setState(() {});
          },
          icon: const Icon(
            Icons.close_rounded,
          ),
        ),
        filled: true,
        fillColor: const Color(0xffF8FAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedFilter,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          items: const [
            DropdownMenuItem(
              value: "All",
              child: Text("All Appointments"),
            ),
            DropdownMenuItem(
              value: "Confirmed",
              child: Text("Confirmed"),
            ),
            DropdownMenuItem(
              value: "Pending",
              child: Text("Pending"),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedFilter = value;
            });
          },
        ),
      ),
    );
  }

  // ============================================================
  // APPOINTMENT LIST
  // ============================================================

  Widget _buildAppointmentList(bool isMobile) {
    final items = filteredAppointments;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Appointment Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightTeal,
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Text(
                "${items.length}",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          "Manage doctor appointments before starting presentations.",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 15),
        if (items.isEmpty)
          _buildEmptyState()
        else
          ...items.map(
                (appointment) => Padding(
              padding: const EdgeInsets.only(
                bottom: 14,
              ),
              child: _buildAppointmentCard(
                appointment,
                isMobile,
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // APPOINTMENT CARD
  // ============================================================

  Widget _buildAppointmentCard(
      Map<String, dynamic> appointment,
      bool isMobile,
      ) {
    final bool confirmed =
        appointment["status"] == "Confirmed";

    final Color avatarColor =
    appointment["color"] as Color;

    return Container(
      width: double.infinity,
      decoration: _cardDecoration(),
      child: Padding(
        padding: EdgeInsets.all(
          isMobile ? 16 : 20,
        ),
        child: isMobile
            ? Column(
          children: [
            _buildDoctorInfo(
              appointment,
              avatarColor,
            ),
            const SizedBox(height: 16),
            _buildDateTime(
              appointment,
            ),
            const SizedBox(height: 14),
            _buildStatus(
              confirmed,
            ),
            const SizedBox(height: 15),
            _buildActions(
              appointment,
              confirmed,
              true,
            ),
          ],
        )
            : Row(
          children: [
            _buildDoctorInfo(
              appointment,
              avatarColor,
            ),
            const SizedBox(width: 25),
            _buildDateTime(
              appointment,
            ),
            const Spacer(),
            _buildStatus(
              confirmed,
            ),
            const SizedBox(width: 20),
            _buildActions(
              appointment,
              confirmed,
              false,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DOCTOR INFORMATION
  // ============================================================

  Widget _buildDoctorInfo(
      Map<String, dynamic> appointment,
      Color avatarColor,
      ) {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: avatarColor.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline_rounded,
              color: avatarColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  appointment["doctor"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appointment["specialty"],
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.local_hospital_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        appointment["hospital"],
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DATE + TIME
  // ============================================================

  Widget _buildDateTime(
      Map<String, dynamic> appointment,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF7FAFA),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.primary,
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                appointment["date"],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 13,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    appointment["time"],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _buildStatus(bool confirmed) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: confirmed
            ? Colors.green.withOpacity(0.09)
            : Colors.orange.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            confirmed
                ? Icons.check_circle
                : Icons.schedule,
            size: 15,
            color: confirmed
                ? Colors.green
                : Colors.orange,
          ),
          const SizedBox(width: 6),
          Text(
            confirmed ? "Confirmed" : "Pending",
            style: TextStyle(
              color: confirmed
                  ? Colors.green
                  : Colors.orange,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  Widget _buildActions(
      Map<String, dynamic> appointment,
      bool confirmed,
      bool isMobile,
      ) {
    return Row(
      mainAxisSize:
      isMobile ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Expanded(
          flex: isMobile ? 1 : 0,
          child: OutlinedButton(
            onPressed: () {
              _showAppointmentDetails(
                appointment,
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              foregroundColor:
              AppColors.primary,
              side: const BorderSide(
                color: AppColors.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "View",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: isMobile ? 1 : 0,
          child: ElevatedButton(
            onPressed: confirmed
                ? () {
              _showRescheduleDialog(
                appointment,
              );
            }
                : () {
              _confirmAppointment(
                appointment,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),
            child: Text(
              confirmed ? "Reschedule" : "Confirm",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DETAILS DIALOG
  // ============================================================

  void _showAppointmentDetails(
      Map<String, dynamic> appointment,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  appointment["doctor"],
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _dialogInfo(
                Icons.local_hospital_outlined,
                "Hospital",
                appointment["hospital"],
              ),
              _dialogInfo(
                Icons.medical_services_outlined,
                "Specialty",
                appointment["specialty"],
              ),
              _dialogInfo(
                Icons.calendar_today_outlined,
                "Date",
                appointment["date"],
              ),
              _dialogInfo(
                Icons.access_time_outlined,
                "Time",
                appointment["time"],
              ),
              _dialogInfo(
                Icons.phone_outlined,
                "Phone",
                appointment["phone"],
              ),
              const SizedBox(height: 8),
              _buildStatus(
                appointment["status"] == "Confirmed",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                "Close",
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogInfo(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: AppColors.primary,
          ),
          const SizedBox(width: 10),
          Text(
            "$title: ",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONFIRM APPOINTMENT
  // ============================================================

  void _confirmAppointment(
      Map<String, dynamic> appointment,
      ) {
    setState(() {
      appointment["status"] = "Confirmed";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Appointment confirmed successfully.",
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // RESCHEDULE
  // ============================================================

  void _showRescheduleDialog(
      Map<String, dynamic> appointment,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Reschedule Appointment",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Appointment rescheduling functionality can be connected to your backend or calendar service.",
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    behavior:
                    SnackBarBehavior.floating,
                    content: Text(
                      "Reschedule option selected.",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text(
                "Continue",
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 20,
      ),
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 15),
          Text(
            "No appointments found",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Try changing your search or filter.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DECORATION
  // ============================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.grey.shade200,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.035),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}