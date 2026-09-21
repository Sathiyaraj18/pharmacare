import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';

class DoctorAppointmentsScreen extends StatelessWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Appointments",
      menu: "doctor",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            // BREADCRUMB
            // ============================================================

            const Breadcrumb(
              items: [
                BreadcrumbItem(
                  title: "Dashboard",
                ),
                BreadcrumbItem(
                  title: "Appointments",
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ============================================================
            // PAGE HEADER
            // ============================================================

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Appointments",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        "Manage your meetings and medicine discussions.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Appointment request feature opened.",
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    "New Appointment",
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      165,
                      48,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ============================================================
            // SUMMARY
            // ============================================================

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _summaryCard(
                  title: "Total",
                  value: "3",
                  subtitle: "All appointments",
                  icon: Icons.calendar_month_outlined,
                  iconColor: Colors.blue,
                  backgroundColor: const Color(0xffEAF3FF),
                ),
                _summaryCard(
                  title: "Confirmed",
                  value: "2",
                  subtitle: "Scheduled meetings",
                  icon: Icons.check_circle_outline,
                  iconColor: Colors.green,
                  backgroundColor: const Color(0xffEAF8EF),
                ),
                _summaryCard(
                  title: "Pending",
                  value: "1",
                  subtitle: "Waiting for confirmation",
                  icon: Icons.pending_actions_outlined,
                  iconColor: Colors.orange,
                  backgroundColor: const Color(0xfffff4dc),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ============================================================
            // TODAY'S APPOINTMENT
            // ============================================================

            const Text(
              "Today's Appointment",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.lightTeal,
                    Color(0xffF7FBFA),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.teal.shade100,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isSmall =
                      constraints.maxWidth < 700;

                  final content = [
                    _todayInfo(
                      Icons.business_outlined,
                      "Company",
                      "ABC Pharma",
                    ),
                    _todayInfo(
                      Icons.access_time_outlined,
                      "Time",
                      "10:30 AM",
                    ),
                    _todayInfo(
                      Icons.location_on_outlined,
                      "Location",
                      "Chennai",
                    ),
                  ];

                  if (isSmall) {
                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 58,
                              width: 58,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today's Meeting",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Medicine discussion",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        ...content.map(
                              (item) => Padding(
                            padding:
                            const EdgeInsets.only(bottom: 14),
                            child: item,
                          ),
                        ),

                        const SizedBox(height: 5),

                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showAppointmentDetails(
                                context,
                                "ABC Pharma",
                                "10:30 AM",
                                "12 Sep 2026",
                                "Confirmed",
                              );
                            },
                            icon: const Icon(
                              Icons.visibility_outlined,
                            ),
                            label: const Text(
                              "View Details",
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 18),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Meeting",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Medicine discussion with medical representative",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ...content.map(
                            (item) => Padding(
                          padding: const EdgeInsets.only(
                            left: 35,
                          ),
                          child: item,
                        ),
                      ),

                      const SizedBox(width: 30),

                      ElevatedButton(
                        onPressed: () {
                          _showAppointmentDetails(
                            context,
                            "ABC Pharma",
                            "10:30 AM",
                            "12 Sep 2026",
                            "Confirmed",
                          );
                        },
                        child: const Text(
                          "View Details",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 35),

            // ============================================================
            // UPCOMING APPOINTMENTS
            // ============================================================

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Upcoming Appointments",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "3 appointments",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            appointmentCard(
              context: context,
              company: "ABC Pharma",
              date: "12 Sep 2026",
              time: "10:30 AM",
              location: "Chennai",
              type: "Medicine Presentation",
              status: "Confirmed",
            ),

            appointmentCard(
              context: context,
              company: "XYZ Pharmaceuticals",
              date: "13 Sep 2026",
              time: "02:30 PM",
              location: "Coimbatore",
              type: "Product Discussion",
              status: "Pending",
            ),

            appointmentCard(
              context: context,
              company: "Premier Therapeutics",
              date: "15 Sep 2026",
              time: "11:00 AM",
              location: "Bengaluru",
              type: "Medicine Review",
              status: "Confirmed",
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SUMMARY CARD
  // ================================================================

  Widget _summaryCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
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

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
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
        ],
      ),
    );
  }

  // ================================================================
  // TODAY INFO
  // ================================================================

  Widget _todayInfo(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 19,
          color: AppColors.primary,
        ),

        const SizedBox(width: 8),

        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ================================================================
  // APPOINTMENT CARD
  // ================================================================

  Widget appointmentCard({
    required BuildContext context,
    required String company,
    required String date,
    required String time,
    required String location,
    required String type,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmall =
              constraints.maxWidth < 750;

          final header = Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  borderRadius:
                  BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.business_outlined,
                  color: AppColors.primary,
                  size: 27,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              _statusChip(status),
            ],
          );

          final details = Row(
            children: [
              Expanded(
                child: _appointmentInfo(
                  Icons.calendar_today_outlined,
                  "Date",
                  date,
                ),
              ),

              Expanded(
                child: _appointmentInfo(
                  Icons.access_time_outlined,
                  "Time",
                  time,
                ),
              ),

              Expanded(
                child: _appointmentInfo(
                  Icons.location_on_outlined,
                  "Location",
                  location,
                ),
              ),
            ],
          );

          if (isSmall) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                header,

                const SizedBox(height: 18),

                const Divider(),

                const SizedBox(height: 14),

                _appointmentInfo(
                  Icons.calendar_today_outlined,
                  "Date",
                  date,
                ),

                const SizedBox(height: 12),

                _appointmentInfo(
                  Icons.access_time_outlined,
                  "Time",
                  time,
                ),

                const SizedBox(height: 12),

                _appointmentInfo(
                  Icons.location_on_outlined,
                  "Location",
                  location,
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _showAppointmentDetails(
                            context,
                            company,
                            time,
                            date,
                            status,
                          );
                        },
                        child: const Text(
                          "View Details",
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Reschedule option selected.",
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Reschedule",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return Column(
            children: [
              header,

              const SizedBox(height: 18),

              Divider(
                color: Colors.grey.shade200,
              ),

              const SizedBox(height: 16),

              details,

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      _showAppointmentDetails(
                        context,
                        company,
                        time,
                        date,
                        status,
                      );
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 18,
                    ),
                    label: const Text(
                      "View Details",
                    ),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Reschedule option selected.",
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_calendar_outlined,
                      size: 18,
                    ),
                    label: const Text(
                      "Reschedule",
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // ================================================================
  // APPOINTMENT INFO
  // ================================================================

  Widget _appointmentInfo(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: AppColors.primary,
        ),

        const SizedBox(width: 9),

        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ================================================================
  // STATUS CHIP
  // ================================================================

  Widget _statusChip(String status) {
    final bool confirmed = status == "Confirmed";

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: confirmed
            ? const Color(0xffEAF8EF)
            : const Color(0xfffff3cd),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            confirmed
                ? Icons.check_circle_outline
                : Icons.pending_outlined,
            size: 16,
            color: confirmed
                ? Colors.green
                : Colors.orange,
          ),

          const SizedBox(width: 6),

          Text(
            status,
            style: TextStyle(
              color: confirmed
                  ? Colors.green
                  : Colors.orange,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // DETAILS DIALOG
  // ================================================================

  void _showAppointmentDetails(
      BuildContext context,
      String company,
      String time,
      String date,
      String status,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Appointment Details",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _dialogRow(
                  "Company",
                  company,
                ),

                _dialogRow(
                  "Date",
                  date,
                ),

                _dialogRow(
                  "Time",
                  time,
                ),

                _dialogRow(
                  "Type",
                  "Medicine Discussion",
                ),

                _dialogRow(
                  "Status",
                  status,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text(
                      "Close",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================================================================
  // DIALOG ROW
  // ================================================================

  Widget _dialogRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}