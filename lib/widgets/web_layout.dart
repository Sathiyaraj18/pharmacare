import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/app_colors.dart';
import 'breadcrumb.dart';

// Doctor screens
import '../screens/doctor/doctor_dashboard.dart';
import '../screens/doctor/doctor_profile.dart';
import '../screens/doctor/doctor_appointments_screen.dart';

// MR screens
import '../screens/mr/mr_dashboard.dart';
import '../screens/mr/mr_doctors_screen.dart';
import '../screens/mr/mr_appointments_screen.dart';
import '../screens/mr/mr_reviews_screen.dart';
import '../screens/mr/presentation_screen.dart';
import '../screens/mr/selected_doctors_screen.dart';
import '../screens/mr/mr_profile_screen.dart';

// Shared screens
import '../screens/shared/medicines_screen.dart';
import '../screens/shared/orders_screen.dart';

// Auth
import '../screens/auth/login_screen.dart';

class WebLayout extends StatefulWidget {
  final String title;
  final String menu;
  final Widget child;

  // ------------------------------------------------------------
  // BREADCRUMB SUPPORT
  // ------------------------------------------------------------

  final List<BreadcrumbItem>? breadcrumbItems;

  const WebLayout({
    super.key,
    required this.title,
    required this.menu,
    required this.child,
    this.breadcrumbItems,
  });

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  // ============================================================
  // SIDEBAR
  // ============================================================

  static bool sidebarExpanded = false;

  // ============================================================
  // DOCTOR INFORMATION
  // ============================================================

  String doctorName = "Doctor";
  String doctorEmail = "";
  String doctorHospital = "ABC Hospital";
  String doctorSpecialty = "Cardiology";
  String doctorRole = "Doctor";

  bool isLoadingDoctor = true;

  // ============================================================
  // MR INFORMATION
  // ============================================================

  String mrName = "MR";
  String mrEmail = "";
  String mrRole = "Medical Representative";

  bool isLoadingMR = true;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    if (widget.menu == "doctor") {
      isLoadingMR = false;
      loadDoctorDetails();
    } else if (widget.menu == "mr") {
      isLoadingDoctor = false;
      loadMRDetails();
    } else {
      isLoadingDoctor = false;
      isLoadingMR = false;
    }
  }

  // ============================================================
  // LOAD DOCTOR DETAILS
  // ============================================================

  Future<void> loadDoctorDetails() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint(
          "WEB LAYOUT: No logged-in doctor.",
        );

        if (mounted) {
          setState(() {
            doctorName = "Doctor";
            doctorEmail = "";
            doctorHospital = "ABC Hospital";
            doctorSpecialty = "Cardiology";
            doctorRole = "Doctor";
            isLoadingDoctor = false;
          });
        }

        return;
      }

      debugPrint(
        "WEB LAYOUT: Logged in UID = ${user.uid}",
      );

      debugPrint(
        "WEB LAYOUT: Auth displayName = ${user.displayName}",
      );

      debugPrint(
        "WEB LAYOUT: Auth email = ${user.email}",
      );

      // ----------------------------------------------------------
      // DEFAULT AUTH VALUES
      // ----------------------------------------------------------

      String name =
      (user.displayName ?? "Doctor").toString().trim();

      String email =
      (user.email ?? "").toString().trim();

      String hospital = "ABC Hospital";

      String specialty = "Cardiology";

      String role = "Doctor";

      if (name.isEmpty) {
        name = "Doctor";
      }

      // ----------------------------------------------------------
      // FIRESTORE
      // ----------------------------------------------------------

      final DocumentSnapshot<Map<String, dynamic>> document =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (document.exists) {
        final Map<String, dynamic>? data =
        document.data();

        debugPrint(
          "WEB LAYOUT: Firestore doctor data = $data",
        );

        final String firestoreName =
        (data?["name"] ??
            user.displayName ??
            "Doctor")
            .toString()
            .trim();

        final String firestoreEmail =
        (data?["email"] ??
            user.email ??
            "")
            .toString()
            .trim();

        final String firestoreHospital =
        (data?["hospital"] ??
            "ABC Hospital")
            .toString()
            .trim();

        final String firestoreSpecialty =
        (data?["specialty"] ??
            "Cardiology")
            .toString()
            .trim();

        final String firestoreRole =
        (data?["role"] ??
            "doctor")
            .toString()
            .trim();

        if (firestoreName.isNotEmpty) {
          name = firestoreName;
        }

        if (firestoreEmail.isNotEmpty) {
          email = firestoreEmail;
        }

        if (firestoreHospital.isNotEmpty) {
          hospital = firestoreHospital;
        }

        if (firestoreSpecialty.isNotEmpty) {
          specialty = firestoreSpecialty;
        }

        if (firestoreRole.isNotEmpty) {
          if (firestoreRole.toLowerCase() == "doctor") {
            role = "Doctor";
          } else {
            role = firestoreRole;
          }
        }
      } else {
        debugPrint(
          "WEB LAYOUT: Firestore doctor document not found.",
        );
      }

      if (!mounted) {
        return;
      }

      setState(() {
        doctorName = name;
        doctorEmail = email;
        doctorHospital = hospital;
        doctorSpecialty = specialty;
        doctorRole = role;
        isLoadingDoctor = false;
      });

      debugPrint(
        "WEB LAYOUT: Doctor name = $doctorName",
      );

      debugPrint(
        "WEB LAYOUT: Email = $doctorEmail",
      );

      debugPrint(
        "WEB LAYOUT: Hospital = $doctorHospital",
      );

      debugPrint(
        "WEB LAYOUT: Specialty = $doctorSpecialty",
      );

      debugPrint(
        "WEB LAYOUT: Role = $doctorRole",
      );
    } catch (e) {
      debugPrint(
        "WEB LAYOUT DOCTOR ERROR: $e",
      );

      final User? user =
          FirebaseAuth.instance.currentUser;

      String fallbackName =
      (user?.displayName ?? "Doctor")
          .toString()
          .trim();

      if (fallbackName.isEmpty) {
        fallbackName = "Doctor";
      }

      if (!mounted) {
        return;
      }

      setState(() {
        doctorName = fallbackName;
        doctorEmail =
            (user?.email ?? "").toString();
        doctorHospital = "ABC Hospital";
        doctorSpecialty = "Cardiology";
        doctorRole = "Doctor";
        isLoadingDoctor = false;
      });
    }
  }

  // ============================================================
  // LOAD MR DETAILS
  // ============================================================

  Future<void> loadMRDetails() async {
    try {
      final User? user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint(
          "WEB LAYOUT: No logged-in MR.",
        );

        if (mounted) {
          setState(() {
            mrName = "MR";
            mrEmail = "";
            mrRole = "Medical Representative";
            isLoadingMR = false;
          });
        }

        return;
      }

      debugPrint(
        "WEB LAYOUT: MR Logged in UID = ${user.uid}",
      );

      debugPrint(
        "WEB LAYOUT: MR Auth displayName = ${user.displayName}",
      );

      debugPrint(
        "WEB LAYOUT: MR Auth email = ${user.email}",
      );

      // ----------------------------------------------------------
      // DEFAULT AUTH VALUES
      // ----------------------------------------------------------

      String name =
      (user.displayName ?? "MR")
          .toString()
          .trim();

      String email =
      (user.email ?? "")
          .toString()
          .trim();

      String role =
          "Medical Representative";

      if (name.isEmpty) {
        name = "MR";
      }

      // ----------------------------------------------------------
      // FIRESTORE
      // ----------------------------------------------------------

      final DocumentSnapshot<Map<String, dynamic>> document =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (document.exists) {
        final Map<String, dynamic>? data =
        document.data();

        debugPrint(
          "WEB LAYOUT: Firestore MR data = $data",
        );

        final String firestoreName =
        (data?["name"] ??
            user.displayName ??
            "MR")
            .toString()
            .trim();

        final String firestoreEmail =
        (data?["email"] ??
            user.email ??
            "")
            .toString()
            .trim();

        final String firestoreRole =
        (data?["role"] ??
            "mr")
            .toString()
            .trim();

        if (firestoreName.isNotEmpty) {
          name = firestoreName;
        }

        if (firestoreEmail.isNotEmpty) {
          email = firestoreEmail;
        }

        if (firestoreRole.isNotEmpty) {
          final String lowerRole =
          firestoreRole.toLowerCase();

          if (lowerRole == "mr" ||
              lowerRole == "medical representative") {
            role = "Medical Representative";
          } else {
            role = firestoreRole;
          }
        }
      } else {
        debugPrint(
          "WEB LAYOUT: Firestore MR document not found.",
        );
      }

      if (!mounted) {
        return;
      }

      setState(() {
        mrName = name;
        mrEmail = email;
        mrRole = role;
        isLoadingMR = false;
      });

      debugPrint(
        "WEB LAYOUT: MR name = $mrName",
      );

      debugPrint(
        "WEB LAYOUT: MR email = $mrEmail",
      );

      debugPrint(
        "WEB LAYOUT: MR role = $mrRole",
      );
    } catch (e) {
      debugPrint(
        "WEB LAYOUT MR ERROR: $e",
      );

      final User? user =
          FirebaseAuth.instance.currentUser;

      String fallbackName =
      (user?.displayName ?? "MR")
          .toString()
          .trim();

      if (fallbackName.isEmpty) {
        fallbackName = "MR";
      }

      if (!mounted) {
        return;
      }

      setState(() {
        mrName = fallbackName;
        mrEmail =
            (user?.email ?? "").toString();
        mrRole = "Medical Representative";
        isLoadingMR = false;
      });
    }
  }

  // ============================================================
  // DOCTOR INITIAL
  // ============================================================

  String getDoctorInitial() {
    final dynamic value = doctorName;

    if (value == null) {
      return "D";
    }

    final String name =
    value.toString().trim();

    if (name.isEmpty) {
      return "D";
    }

    return name
        .substring(0, 1)
        .toUpperCase();
  }

  // ============================================================
  // MR INITIAL
  // ============================================================

  String getMRInitial() {
    final dynamic value = mrName;

    if (value == null) {
      return "M";
    }

    final String name =
    value.toString().trim();

    if (name.isEmpty) {
      return "M";
    }

    return name
        .substring(0, 1)
        .toUpperCase();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isDesktop =
        screenWidth >= 900;

    return Scaffold(
      // ==========================================================
      // MOBILE DRAWER
      // ==========================================================

      drawer: !isDesktop
          ? Drawer(
        child: Container(
          color: AppColors.dark,
          child: SafeArea(
            child: Column(
              children: [
                // ------------------------------------------
                // MOBILE HEADER
                // ------------------------------------------

                Container(
                  height: 75,
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white
                              .withOpacity(
                            0.10,
                          ),
                          borderRadius:
                          BorderRadius
                              .circular(
                            12,
                          ),
                        ),
                        child: const Icon(
                          Icons
                              .medical_services_outlined,
                          color:
                          Colors.white,
                          size: 25,
                        ),
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      const Text(
                        "PharmaCare",
                        style:
                        TextStyle(
                          color:
                          Colors.white,
                          fontSize: 21,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.white24,
                  height: 1,
                ),

                // ------------------------------------------
                // MENU
                // ------------------------------------------

                Expanded(
                  child: ListView(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 12,
                    ),
                    children:
                    widget.menu ==
                        "doctor"
                        ? doctorMenu(
                      context,
                    )
                        : mrMenu(
                      context,
                    ),
                  ),
                ),

                // ------------------------------------------
                // LOGOUT
                // ------------------------------------------

                const Divider(
                  color: Colors.white24,
                  height: 1,
                ),

                ListTile(
                  leading:
                  const Icon(
                    Icons
                        .settings_outlined,
                    color:
                    Colors.white70,
                  ),
                  title:
                  const Text(
                    "Settings",
                    style:
                    TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),

                ListTile(
                  leading:
                  const Icon(
                    Icons.logout,
                    color:
                    Colors.white70,
                  ),
                  title:
                  const Text(
                    "Logout",
                    style:
                    TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                  onTap: () {
                    logout(
                      context,
                    );
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      )
          : null,

      // ==========================================================
      // BODY
      // ==========================================================

      body: Row(
        children: [
          // ========================================================
          // DESKTOP SIDEBAR
          // ========================================================

          if (isDesktop)
            AnimatedContainer(
              duration:
              const Duration(
                milliseconds: 250,
              ),
              width:
              sidebarExpanded
                  ? 240
                  : 76,
              height:
              double.infinity,
              color:
              AppColors.dark,
              child: Column(
                children: [
                  // ----------------------------------------------
                  // LOGO
                  // ----------------------------------------------

                  const SizedBox(
                    height: 22,
                  ),

                  Container(
                    height: 48,
                    width: 48,
                    decoration:
                    BoxDecoration(
                      color:
                      Colors.white
                          .withOpacity(
                        0.08,
                      ),
                      borderRadius:
                      BorderRadius
                          .circular(
                        14,
                      ),
                    ),
                    child: const Icon(
                      Icons
                          .medical_services_outlined,
                      color:
                      Colors.white,
                      size: 28,
                    ),
                  ),

                  if (sidebarExpanded)
                    const Padding(
                      padding:
                      EdgeInsets.only(
                        top: 10,
                      ),
                      child:
                      Text(
                        "PharmaCare",
                        style:
                        TextStyle(
                          color:
                          Colors.white,
                          fontSize: 21,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(
                    height: 22,
                  ),

                  const Divider(
                    color:
                    Colors.white24,
                    height: 1,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // ----------------------------------------------
                  // MENU
                  // ----------------------------------------------

                  Expanded(
                    child:
                    ListView(
                      padding:
                      EdgeInsets.zero,
                      children:
                      widget.menu ==
                          "doctor"
                          ? doctorMenu(
                        context,
                      )
                          : mrMenu(
                        context,
                      ),
                    ),
                  ),

                  // ----------------------------------------------
                  // SETTINGS
                  // ----------------------------------------------

                  sidebarItem(
                    context,
                    Icons
                        .settings_outlined,
                    "Settings",
                    null,
                  ),

                  // ----------------------------------------------
                  // LOGOUT
                  // ----------------------------------------------

                  sidebarItem(
                    context,
                    Icons.logout,
                    "Logout",
                    null,
                    onTap: () {
                      logout(
                        context,
                      );
                    },
                  ),

                  // ----------------------------------------------
                  // EXPAND / COLLAPSE
                  // ----------------------------------------------

                  const SizedBox(
                    height: 8,
                  ),

                  IconButton(
                    onPressed: () {
                      setState(() {
                        sidebarExpanded =
                        !sidebarExpanded;
                      });
                    },
                    icon: Icon(
                      sidebarExpanded
                          ? Icons
                          .chevron_left
                          : Icons
                          .chevron_right,
                      color:
                      Colors.white70,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

          // ========================================================
          // RIGHT SIDE
          // ========================================================

          Expanded(
            child: Container(
              color:
              const Color(
                0xffF4F8F7,
              ),
              child: Column(
                children: [
                  // ==================================================
                  // APP BAR
                  // ==================================================

                  Container(
                    height: 75,
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 30,
                    ),
                    color:
                    Colors.white,
                    child: Row(
                      children: [
                        // ------------------------------------------
                        // MOBILE MENU BUTTON
                        // ------------------------------------------

                        if (!isDesktop)
                          Builder(
                            builder:
                                (context) {
                              return IconButton(
                                onPressed:
                                    () {
                                  Scaffold.of(
                                    context,
                                  ).openDrawer();
                                },
                                icon:
                                const Icon(
                                  Icons.menu,
                                ),
                              );
                            },
                          ),

                        if (!isDesktop)
                          const SizedBox(
                            width: 8,
                          ),

                        // ------------------------------------------
                        // TITLE
                        // ------------------------------------------

                        Expanded(
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow:
                            TextOverflow
                                .ellipsis,
                            style:
                            const TextStyle(
                              fontSize: 22,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                        ),

                        // ------------------------------------------
                        // NOTIFICATION
                        // ------------------------------------------

                        IconButton(
                          onPressed: () {
                            _showMessage(
                              context,
                              "Notifications",
                            );
                          },
                          icon:
                          const Icon(
                            Icons
                                .notifications_none,
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        // ------------------------------------------
                        // PROFILE
                        // ------------------------------------------

                        if (widget.menu ==
                            "doctor")
                          doctorAppBarProfile(
                            context,
                          )
                        else if (widget.menu ==
                            "mr")
                          mrAppBarProfile(
                            context,
                          ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // BREADCRUMB + PAGE
                  // ==================================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        // --------------------------------------------
                        // BREADCRUMB
                        // --------------------------------------------

                        if (widget
                            .breadcrumbItems !=
                            null &&
                            widget
                                .breadcrumbItems!
                                .isNotEmpty)
                          Padding(
                            padding:
                            const EdgeInsets
                                .fromLTRB(
                              30,
                              25,
                              30,
                              0,
                            ),
                            child:
                            Breadcrumb(
                              items: widget
                                  .breadcrumbItems!,
                            ),
                          ),

                        // --------------------------------------------
                        // SCREEN
                        // --------------------------------------------

                        Expanded(
                          child:
                          widget.child,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DOCTOR APPBAR PROFILE
  // ============================================================

  Widget doctorAppBarProfile(
      BuildContext context,
      ) {
    return InkWell(
      onTap: () {
        showDoctorDetailsPopup(
          context,
        );
      },
      borderRadius:
      BorderRadius.circular(
        30,
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          // ----------------------------------------------
          // CIRCLE AVATAR
          // ----------------------------------------------

          CircleAvatar(
            radius: 21,
            backgroundColor:
            AppColors.lightTeal,
            child: isLoadingDoctor
                ? const SizedBox(
              width: 16,
              height: 16,
              child:
              CircularProgressIndicator(
                strokeWidth: 2,
                color:
                AppColors.primary,
              ),
            )
                : Text(
              getDoctorInitial(),
              style:
              const TextStyle(
                color:
                AppColors.primary,
                fontSize: 17,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          // ----------------------------------------------
          // NAME
          // ----------------------------------------------

          if (!isLoadingDoctor)
            ConstrainedBox(
              constraints:
              const BoxConstraints(
                maxWidth: 150,
              ),
              child: Text(
                doctorName,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style:
                const TextStyle(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),

          const SizedBox(
            width: 3,
          ),

          const Icon(
            Icons
                .keyboard_arrow_down,
            size: 20,
            color:
            Colors.grey,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MR APPBAR PROFILE
  // ============================================================

  Widget mrAppBarProfile(
      BuildContext context,
      ) {
    return InkWell(
      onTap: () {
        showMRDetailsPopup(
          context,
        );
      },
      borderRadius:
      BorderRadius.circular(
        30,
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          // ----------------------------------------------
          // MR AVATAR
          // ----------------------------------------------

          CircleAvatar(
            radius: 21,
            backgroundColor:
            AppColors.lightTeal,
            child: isLoadingMR
                ? const SizedBox(
              width: 16,
              height: 16,
              child:
              CircularProgressIndicator(
                strokeWidth: 2,
                color:
                AppColors.primary,
              ),
            )
                : Text(
              getMRInitial(),
              style:
              const TextStyle(
                color:
                AppColors.primary,
                fontSize: 17,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          // ----------------------------------------------
          // MR NAME
          // ----------------------------------------------

          if (!isLoadingMR)
            ConstrainedBox(
              constraints:
              const BoxConstraints(
                maxWidth: 150,
              ),
              child: Text(
                mrName.toString(),
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style:
                const TextStyle(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),

          const SizedBox(
            width: 3,
          ),

          const Icon(
            Icons
                .keyboard_arrow_down,
            size: 20,
            color:
            Colors.grey,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DOCTOR DETAILS POPUP
  // ============================================================

  void showDoctorDetailsPopup(
      BuildContext context,
      ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          insetPadding:
          const EdgeInsets
              .symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              20,
            ),
          ),
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(
              maxWidth: 480,
              maxHeight: 620,
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                // ==================================================
                // POPUP HEADER
                // ==================================================

                Container(
                  width:
                  double.infinity,
                  padding:
                  const EdgeInsets
                      .all(20),
                  decoration:
                  const BoxDecoration(
                    gradient:
                    LinearGradient(
                      begin:
                      Alignment.topLeft,
                      end:
                      Alignment.bottomRight,
                      colors: [
                        Color(
                          0xff0E746B,
                        ),
                        Color(
                          0xff15978D,
                        ),
                        Color(
                          0xff20AA9E,
                        ),
                      ],
                    ),
                    borderRadius:
                    BorderRadius.only(
                      topLeft:
                      Radius.circular(
                        20,
                      ),
                      topRight:
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // --------------------------------------------
                      // LARGE AVATAR
                      // --------------------------------------------

                      CircleAvatar(
                        radius: 31,
                        backgroundColor:
                        Colors.white,
                        child:
                        CircleAvatar(
                          radius: 27,
                          backgroundColor:
                          AppColors
                              .lightTeal,
                          child: Text(
                            getDoctorInitial(),
                            style:
                            const TextStyle(
                              color:
                              AppColors
                                  .primary,
                              fontSize: 24,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 14,
                      ),

                      // --------------------------------------------
                      // NAME
                      // --------------------------------------------

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              doctorName,
                              maxLines: 2,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white,
                                fontSize: 19,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(
                              doctorSpecialty,
                              maxLines: 1,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --------------------------------------------
                      // CLOSE BUTTON
                      // --------------------------------------------

                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                          );
                        },
                        icon:
                        const Icon(
                          Icons.close,
                          color:
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // POPUP BODY
                // ==================================================

                Flexible(
                  child:
                  SingleChildScrollView(
                    padding:
                    const EdgeInsets
                        .all(20),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        const Text(
                          "Doctor Details",
                          style:
                          TextStyle(
                            fontSize: 19,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // ------------------------------------------
                        // NAME
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .person_outline,
                          title:
                          "Doctor Name",
                          value:
                          doctorName,
                        ),

                        // ------------------------------------------
                        // EMAIL
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .email_outlined,
                          title:
                          "Email",
                          value:
                          doctorEmail
                              .isEmpty
                              ? "Not available"
                              : doctorEmail,
                        ),

                        // ------------------------------------------
                        // HOSPITAL
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .local_hospital_outlined,
                          title:
                          "Hospital / Clinic",
                          value:
                          doctorHospital,
                        ),

                        // ------------------------------------------
                        // SPECIALIZATION
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .medical_information_outlined,
                          title:
                          "Specialization",
                          value:
                          doctorSpecialty,
                        ),

                        // ------------------------------------------
                        // ROLE
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .badge_outlined,
                          title:
                          "Role",
                          value:
                          doctorRole,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // ------------------------------------------
                        // EDIT PROFILE
                        // ------------------------------------------

                        SizedBox(
                          width:
                          double.infinity,
                          height: 46,
                          child:
                          ElevatedButton
                              .icon(
                            onPressed:
                                () async {
                              Navigator.pop(
                                dialogContext,
                              );

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                  const DoctorProfile(),
                                ),
                              );

                              await loadDoctorDetails();
                            },
                            icon:
                            const Icon(
                              Icons
                                  .edit_outlined,
                              size: 18,
                            ),
                            label:
                            const Text(
                              "Edit Profile",
                            ),
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              AppColors
                                  .primary,
                              foregroundColor:
                              Colors
                                  .white,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  // ============================================================
  // MR DETAILS POPUP
  // ============================================================

  void showMRDetailsPopup(
      BuildContext context,
      ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          insetPadding:
          const EdgeInsets
              .symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              20,
            ),
          ),
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(
              maxWidth: 480,
              maxHeight: 620,
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                // ==================================================
                // POPUP HEADER
                // ==================================================

                Container(
                  width:
                  double.infinity,
                  padding:
                  const EdgeInsets
                      .all(20),
                  decoration:
                  const BoxDecoration(
                    gradient:
                    LinearGradient(
                      begin:
                      Alignment.topLeft,
                      end:
                      Alignment.bottomRight,
                      colors: [
                        Color(
                          0xff0E746B,
                        ),
                        Color(
                          0xff15978D,
                        ),
                        Color(
                          0xff20AA9E,
                        ),
                      ],
                    ),
                    borderRadius:
                    BorderRadius.only(
                      topLeft:
                      Radius.circular(
                        20,
                      ),
                      topRight:
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // --------------------------------------------
                      // LARGE MR AVATAR
                      // --------------------------------------------

                      CircleAvatar(
                        radius: 31,
                        backgroundColor:
                        Colors.white,
                        child:
                        CircleAvatar(
                          radius: 27,
                          backgroundColor:
                          AppColors
                              .lightTeal,
                          child: Text(
                            getMRInitial(),
                            style:
                            const TextStyle(
                              color:
                              AppColors
                                  .primary,
                              fontSize: 24,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 14,
                      ),

                      // --------------------------------------------
                      // MR NAME + ROLE
                      // --------------------------------------------

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              mrName.toString(),
                              maxLines: 2,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white,
                                fontSize: 19,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(
                              mrRole.toString(),
                              maxLines: 1,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --------------------------------------------
                      // CLOSE BUTTON
                      // --------------------------------------------

                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                          );
                        },
                        icon:
                        const Icon(
                          Icons.close,
                          color:
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // POPUP BODY
                // ==================================================

                Flexible(
                  child:
                  SingleChildScrollView(
                    padding:
                    const EdgeInsets
                        .all(20),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        const Text(
                          "MR Details",
                          style:
                          TextStyle(
                            fontSize: 19,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // ------------------------------------------
                        // NAME
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .person_outline,
                          title:
                          "MR Name",
                          value:
                          mrName.toString(),
                        ),

                        // ------------------------------------------
                        // EMAIL
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .email_outlined,
                          title:
                          "Email",
                          value:
                          mrEmail
                              .toString()
                              .isEmpty
                              ? "Not available"
                              : mrEmail.toString(),
                        ),

                        // ------------------------------------------
                        // ROLE
                        // ------------------------------------------

                        popupDetail(
                          icon: Icons
                              .badge_outlined,
                          title:
                          "Role",
                          value:
                          mrRole.toString(),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        // ------------------------------------------
                        // EDIT PROFILE
                        // ------------------------------------------

                        SizedBox(
                          width:
                          double.infinity,
                          height: 46,
                          child:
                          ElevatedButton
                              .icon(
                            onPressed:
                                () async {
                              Navigator.pop(
                                dialogContext,
                              );

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                  const MRProfileScreen(),
                                ),
                              );

                              await loadMRDetails();
                            },
                            icon:
                            const Icon(
                              Icons
                                  .edit_outlined,
                              size: 18,
                            ),
                            label:
                            const Text(
                              "Edit Profile",
                            ),
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              AppColors
                                  .primary,
                              foregroundColor:
                              Colors
                                  .white,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  // ============================================================
  // POPUP DETAIL ITEM
  // ============================================================

  Widget popupDetail({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width:
      double.infinity,
      margin:
      const EdgeInsets.only(
        bottom: 10,
      ),
      padding:
      const EdgeInsets.all(
        11,
      ),
      decoration:
      BoxDecoration(
        color:
        const Color(
          0xffF8FAFA,
        ),
        borderRadius:
        BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color:
          Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // ----------------------------------------------
          // ICON
          // ----------------------------------------------

          Container(
            height: 38,
            width: 38,
            decoration:
            BoxDecoration(
              color:
              AppColors.lightTeal,
              borderRadius:
              BorderRadius.circular(
                10,
              ),
            ),
            child: Icon(
              icon,
              color:
              AppColors.primary,
              size: 20,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          // ----------------------------------------------
          // TEXT
          // ----------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  title,
                  style:
                  const TextStyle(
                    color:
                    Colors.grey,
                    fontSize: 10,
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(
                  value,
                  maxLines: 2,
                  overflow:
                  TextOverflow
                      .ellipsis,
                  style:
                  const TextStyle(
                    fontSize: 14,
                    fontWeight:
                    FontWeight.w600,
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
  // DOCTOR MENU
  // ============================================================

  List<Widget> doctorMenu(
      BuildContext context,
      ) {
    return [
      sidebarItem(
        context,
        Icons.dashboard_outlined,
        "Dashboard",
        const DoctorDashboard(),
      ),

      sidebarItem(
        context,
        Icons.person_outline,
        "My Profile",
        const DoctorProfile(),
      ),

      sidebarItem(
        context,
        Icons.medication_outlined,
        "Medicines",
        const MedicinesScreen(),
      ),

      sidebarItem(
        context,
        Icons.shopping_cart_outlined,
        "My Orders",
        const OrdersScreen(),
      ),

      sidebarItem(
        context,
        Icons.calendar_month_outlined,
        "Appointments",
        const DoctorAppointmentsScreen(),
      ),
    ];
  }

  // ============================================================
  // MR MENU
  // ============================================================

  List<Widget> mrMenu(
      BuildContext context,
      ) {
    return [
      sidebarItem(
        context,
        Icons.dashboard_outlined,
        "Dashboard",
        const MRDashboard(),
      ),

      sidebarItem(
        context,
        Icons.person_outline,
        "My Profile",
        const MRProfileScreen(),
      ),

      sidebarItem(
        context,
        Icons.people_outline,
        "Doctors",
        const MRDoctorsScreen(),
      ),

      sidebarItem(
        context,
        Icons.check_circle_outline,
        "Selected Doctors",
        const SelectedDoctorsScreen(
          doctors: [],
        ),
      ),

      sidebarItem(
        context,
        Icons.calendar_month_outlined,
        "Appointments",
        const MRAppointmentsScreen(),
      ),

      sidebarItem(
        context,
        Icons.present_to_all_outlined,
        "Presentations",
        const PresentationScreen(),
      ),

      sidebarItem(
        context,
        Icons.star_outline,
        "Reviews",
        const MRReviewsScreen(),
      ),
    ];
  }

  // ============================================================
  // SIDEBAR ITEM
  // ============================================================

  Widget sidebarItem(
      BuildContext context,
      IconData icon,
      String title,
      Widget? page, {
        VoidCallback? onTap,
      }) {
    final bool expanded =
        sidebarExpanded;

    return SizedBox(
      height: 60,
      child: InkWell(
        onTap: onTap ??
            (page == null
                ? null
                : () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  page,
                ),
              );
            }),
        child: Row(
          children: [
            // ----------------------------------------------
            // FIXED ICON AREA
            // ----------------------------------------------

            SizedBox(
              width: 76,
              child: Center(
                child: Icon(
                  icon,
                  color:
                  Colors.white70,
                  size: 22,
                ),
              ),
            ),

            // ----------------------------------------------
            // TITLE
            // ----------------------------------------------

            if (expanded)
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow:
                  TextOverflow
                      .ellipsis,
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout(
      BuildContext context,
      ) async {
    final bool? confirm =
    await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) {
        return AlertDialog(
          title:
          const Text(
            "Logout",
          ),
          content:
          const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child:
              const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child:
              const Text(
                "Logout",
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    await FirebaseAuth.instance
        .signOut();

    if (!context.mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),
          (route) => false,
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}