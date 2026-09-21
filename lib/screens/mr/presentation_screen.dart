import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/breadcrumb.dart';
import '../../widgets/web_layout.dart';

import 'mr_dashboard.dart';
import 'review_screen.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() =>
      _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> medicines = [
    {
      "name": "SLEW TABLET",
      "molecule": "Example Molecule",
      "strength": "2 mg",
      "company": "ABC Pharmaceuticals",
      "division": "Cardiology",
      "indication": "Cardiovascular Care",
      "description":
      "Slew Tablet is presented as part of the cardiology portfolio.",
      "benefits": [
        "Supports cardiovascular treatment",
        "Convenient tablet formulation",
        "Available in multiple strengths",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Use only as prescribed. Review patient history before prescribing.",
    },
    {
      "name": "CARDIOSAFE TABLET",
      "molecule": "Cardio Molecule",
      "strength": "5 mg",
      "company": "ABC Pharmaceuticals",
      "division": "Cardiology",
      "indication": "Heart Care",
      "description":
      "CardioSafe is part of the company's cardiovascular medicine portfolio.",
      "benefits": [
        "Designed for cardiovascular care",
        "Multiple dosage options",
        "Easy-to-use tablet format",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Use according to the approved prescribing information.",
    },
    {
      "name": "HEARTCARE TABLET",
      "molecule": "Heart Molecule",
      "strength": "10 mg",
      "company": "XYZ Pharma",
      "division": "Cardiology",
      "indication": "Cardiac Care",
      "description":
      "HeartCare is a cardiovascular medicine presented for physician evaluation.",
      "benefits": [
        "Part of cardiovascular portfolio",
        "Available in different strengths",
        "Suitable for physician discussion",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Prescribe after reviewing patient-specific requirements.",
    },
    {
      "name": "CARDIOMAX TABLET",
      "molecule": "Cardio Max Molecule",
      "strength": "20 mg",
      "company": "Premier Therapeutics",
      "division": "Cardiology",
      "indication": "Cardiovascular Management",
      "description":
      "CardioMax is another product from the cardiology division.",
      "benefits": [
        "Cardiology-focused product",
        "Professional physician presentation",
        "Multiple strength availability",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Follow the product prescribing information.",
    },
    {
      "name": "DIABETIX TABLET",
      "molecule": "Diabetes Molecule",
      "strength": "500 mg",
      "company": "HealthCare Labs",
      "division": "Diabetology",
      "indication": "Diabetes Care",
      "description":
      "Diabetix belongs to the diabetology portfolio.",
      "benefits": [
        "Designed for diabetes care",
        "Convenient tablet formulation",
        "Suitable for physician discussion",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Use according to approved prescribing information.",
    },
    {
      "name": "GLYCOSAFE TABLET",
      "molecule": "Glyco Molecule",
      "strength": "10 mg",
      "company": "XYZ Pharma",
      "division": "Diabetology",
      "indication": "Glycemic Management",
      "description":
      "GlycoSafe is presented as part of the diabetes portfolio.",
      "benefits": [
        "Diabetology-focused product",
        "Multiple strength options",
        "Physician-focused presentation",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Review patient requirements and prescribing information.",
    },
    {
      "name": "ORTHORELIEF TABLET",
      "molecule": "Ortho Molecule",
      "strength": "100 mg",
      "company": "ABC Pharmaceuticals",
      "division": "Orthopedics",
      "indication": "Orthopedic Care",
      "description":
      "OrthoRelief belongs to the orthopedic medicine portfolio.",
      "benefits": [
        "Orthopedic-focused medicine",
        "Tablet formulation",
        "Suitable for doctor discussion",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Use only according to approved prescribing information.",
    },
    {
      "name": "NEUROCARE TABLET",
      "molecule": "Neuro Molecule",
      "strength": "25 mg",
      "company": "Premier Therapeutics",
      "division": "Neurology",
      "indication": "Neurological Care",
      "description":
      "NeuroCare is part of the neurology medicine portfolio.",
      "benefits": [
        "Neurology-focused product",
        "Professional product presentation",
        "Multiple product options",
      ],
      "dosage": "As directed by the physician",
      "safety":
      "Follow approved prescribing information.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final medicine = medicines[currentIndex];

    return WebLayout(
      title: "Medicine Presentation",
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
        const BreadcrumbItem(
          title: "Presentations",
        ),
      ],
      child: Container(
        color: const Color(0xffF1F5F5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isTablet = constraints.maxWidth < 1000;
            final bool isMobile = constraints.maxWidth < 700;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 35,
                  vertical: isMobile ? 18 : 25,
                ),
                child: Column(
                  children: [
                    _buildPresentationHeader(
                      medicine,
                      isMobile,
                    ),

                    const SizedBox(height: 18),

                    _buildPresentationBody(
                      medicine,
                      isTablet,
                      isMobile,
                    ),

                    const SizedBox(height: 18),

                    _buildBottomNavigation(
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
  // PRESENTATION HEADER
  // ============================================================

  Widget _buildPresentationHeader(
      Map<String, dynamic> medicine,
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 28,
        vertical: isMobile ? 18 : 20,
      ),
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
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  "PRODUCT PRESENTATION",
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.3,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  medicine["division"],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          if (!isMobile)
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                const Text(
                  "PRESENTATION",
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "${currentIndex + 1} / ${medicines.length}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ============================================================
  // MAIN PRESENTATION BODY
  // ============================================================

  Widget _buildPresentationBody(
      Map<String, dynamic> medicine,
      bool isTablet,
      bool isMobile,
      ) {
    if (isTablet) {
      return Column(
        children: [
          _buildMedicineHero(
            medicine,
            isMobile,
          ),

          const SizedBox(height: 18),

          _buildDiscussionPanel(
            medicine,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _buildMedicineHero(
            medicine,
            false,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          flex: 4,
          child: _buildDiscussionPanel(
            medicine,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MEDICINE HERO
  // ============================================================

  Widget _buildMedicineHero(
      Map<String, dynamic> medicine,
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // ======================================================
          // HERO TOP
          // ======================================================

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(
              isMobile ? 25 : 40,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.82),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
              const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Column(
              children: [
                // PRODUCT ICON
                Container(
                  height: isMobile ? 95 : 120,
                  width: isMobile ? 95 : 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.medication_outlined,
                    size: isMobile ? 52 : 65,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 25),

                // PRODUCT NAME
                Text(
                  medicine["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 28 : 38,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 9),

                // MOLECULE
                Text(
                  medicine["molecule"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: isMobile ? 15 : 18,
                  ),
                ),

                const SizedBox(height: 18),

                // STRENGTH
                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.15),
                    borderRadius:
                    BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.25),
                    ),
                  ),
                  child: Text(
                    medicine["strength"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // PRODUCT INFORMATION
          // ======================================================

          Padding(
            padding: EdgeInsets.all(
              isMobile ? 20 : 28,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _heroInfo(
                        "THERAPEUTIC AREA",
                        medicine["indication"],
                        Icons.health_and_safety_outlined,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _heroInfo(
                        "COMPANY",
                        medicine["company"],
                        Icons.business_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // DESCRIPTION
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7FAFA),
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "PRODUCT INFORMATION",
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.8,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        medicine["description"],
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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
  // HERO INFO
  // ============================================================

  Widget _heroInfo(
      String title,
      String value,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
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
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 19,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
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
  // RIGHT DISCUSSION PANEL
  // ============================================================

  Widget _buildDiscussionPanel(
      Map<String, dynamic> medicine,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // ======================================================
          // TITLE
          // ======================================================

          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColors.lightTeal,
                  borderRadius:
                  BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.record_voice_over_outlined,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Key Discussion",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      "Points for physician discussion",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ======================================================
          // BENEFITS
          // ======================================================

          ...List.generate(
            (medicine["benefits"] as List).length,
                (index) {
              return _presentationPoint(
                index + 1,
                medicine["benefits"][index],
              );
            },
          ),

          const SizedBox(height: 18),

          // ======================================================
          // DOSAGE
          // ======================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xffF7FAFA),
              borderRadius:
              BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.schedule_outlined,
                  color: AppColors.primary,
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "DOSAGE INFORMATION",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        medicine["dosage"],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // ======================================================
          // SAFETY
          // ======================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xfffff8e7),
              borderRadius:
              BorderRadius.circular(15),
              border: Border.all(
                color: Colors.orange.shade200,
              ),
            ),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.orange,
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SAFETY INFORMATION",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.orange,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        medicine["safety"],
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
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
  // PRESENTATION POINT
  // ============================================================

  Widget _presentationPoint(
      int number,
      String text,
      ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              "$number",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation(
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 15 : 18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: isMobile
          ? Column(
        children: [
          _buildSlideIndicator(),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _previousButton(),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _nextButton(),
              ),
            ],
          ),
        ],
      )
          : Row(
        children: [
          _previousButton(),

          const SizedBox(width: 25),

          Expanded(
            child: _buildSlideIndicator(),
          ),

          const SizedBox(width: 25),

          _nextButton(),
        ],
      ),
    );
  }

  // ============================================================
  // PREVIOUS BUTTON
  // ============================================================

  Widget _previousButton() {
    return OutlinedButton.icon(
      onPressed: currentIndex == 0
          ? null
          : () {
        setState(() {
          currentIndex--;
        });
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
        size: 19,
      ),
      label: const Text(
        "Previous",
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        foregroundColor: AppColors.primary,
        side: BorderSide(
          color: currentIndex == 0
              ? Colors.grey.shade300
              : AppColors.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(11),
        ),
      ),
    );
  }

  // ============================================================
  // NEXT BUTTON
  // ============================================================

  Widget _nextButton() {
    final bool last =
        currentIndex == medicines.length - 1;

    return ElevatedButton.icon(
      onPressed: () {
        if (!last) {
          setState(() {
            currentIndex++;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const ReviewScreen(),
            ),
          );
        }
      },
      icon: Icon(
        last
            ? Icons.rate_review_outlined
            : Icons.arrow_forward_rounded,
        size: 19,
      ),
      label: Text(
        last ? "Finish Presentation" : "Next",
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(11),
        ),
      ),
    );
  }

  // ============================================================
  // SLIDE INDICATOR
  // ============================================================

  Widget _buildSlideIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: List.generate(
            medicines.length,
                (index) {
              final bool active =
                  index == currentIndex;

              return AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                margin:
                const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                height: 6,
                width: active ? 28 : 7,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Slide ${currentIndex + 1} of ${medicines.length}",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}