import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';
import 'medicine_detail_screen.dart';

class CompanyMedicinesScreen extends StatefulWidget {
  final String company;

  const CompanyMedicinesScreen({
    super.key,
    this.company = "ABC Pharmaceuticals",
  });

  @override
  State<CompanyMedicinesScreen> createState() =>
      _CompanyMedicinesScreenState();
}

class _CompanyMedicinesScreenState
    extends State<CompanyMedicinesScreen> {
  int currentPage = 1;

  final int itemsPerPage = 4;

  String searchText = "";
  String selectedCategory = "All";

  final List<Map<String, String>> medicines = [
    {
      "name": "Slew",
      "molecule": "Example Molecule A",
      "category": "Cardiology",
    },
    {
      "name": "CardioSafe",
      "molecule": "Example Molecule B",
      "category": "Cardiology",
    },
    {
      "name": "HeartCare",
      "molecule": "Example Molecule C",
      "category": "Cardiology",
    },
    {
      "name": "CardioMax",
      "molecule": "Example Molecule D",
      "category": "Cardiology",
    },
    {
      "name": "Diabetix",
      "molecule": "Example Molecule E",
      "category": "Diabetology",
    },
    {
      "name": "GlycoSafe",
      "molecule": "Example Molecule F",
      "category": "Diabetology",
    },
    {
      "name": "OrthoRelief",
      "molecule": "Example Molecule G",
      "category": "Orthopedics",
    },
    {
      "name": "NeuroCare",
      "molecule": "Example Molecule H",
      "category": "Neurology",
    },
  ];

  List<Map<String, String>> get filteredMedicines {
    return medicines.where((medicine) {
      final String name =
      medicine["name"]!.toLowerCase();

      final String molecule =
      medicine["molecule"]!.toLowerCase();

      final String category =
      medicine["category"]!.toLowerCase();

      final String search =
      searchText.toLowerCase().trim();

      final bool matchesSearch =
          name.contains(search) ||
              molecule.contains(search) ||
              category.contains(search);

      final bool matchesCategory =
          selectedCategory == "All" ||
              medicine["category"] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<String> get categories {
    final Set<String> categorySet = medicines
        .map(
          (medicine) => medicine["category"]!,
    )
        .toSet();

    return [
      "All",
      ...categorySet,
    ];
  }

  int get totalPages {
    if (filteredMedicines.isEmpty) {
      return 1;
    }

    return (filteredMedicines.length / itemsPerPage).ceil();
  }

  List<Map<String, String>> get currentMedicines {
    final List<Map<String, String>> filtered =
        filteredMedicines;

    if (filtered.isEmpty) {
      return [];
    }

    int startIndex =
        (currentPage - 1) * itemsPerPage;

    if (startIndex >= filtered.length) {
      startIndex = 0;
    }

    int endIndex =
        startIndex + itemsPerPage;

    if (endIndex > filtered.length) {
      endIndex = filtered.length;
    }

    return filtered.sublist(
      startIndex,
      endIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: widget.company,
      menu: "doctor",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Breadcrumb(
              items: [
                const BreadcrumbItem(
                  title: "Dashboard",
                ),
                const BreadcrumbItem(
                  title: "Medicines",
                ),
                BreadcrumbItem(
                  title: widget.company,
                ),
              ],
            ),

            const SizedBox(height: 25),

            _companyHeader(),

            const SizedBox(height: 25),

            _companyStats(),

            const SizedBox(height: 30),

            _searchBox(),

            const SizedBox(height: 25),

            _categorySection(),

            const SizedBox(height: 30),

            _medicineTitle(),

            const SizedBox(height: 18),

            if (currentMedicines.isEmpty)
              _emptyState()
            else
              ...currentMedicines.map(
                    (medicine) =>
                    _medicineCard(medicine),
              ),

            const SizedBox(height: 20),

            if (filteredMedicines.isNotEmpty)
              _pagination(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COMPANY HEADER
  // ============================================================

  Widget _companyHeader() {
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
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool small =
              constraints.maxWidth < 650;

          if (small) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                _companyIcon(),
                const SizedBox(height: 18),
                _companyDetails(),
              ],
            );
          }

          return Row(
            children: [
              _companyIcon(),
              const SizedBox(width: 20),
              Expanded(
                child: _companyDetails(),
              ),
              _verifiedBadge(),
            ],
          );
        },
      ),
    );
  }

  Widget _companyIcon() {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(21),
      ),
      child: const Icon(
        Icons.business_outlined,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  Widget _companyDetails() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          widget.company,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Headquarters: Mumbai, Maharashtra",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 18,
          runSpacing: 8,
          children: [
            _headerInfo(
              Icons.medication_outlined,
              "${medicines.length} Medicines",
            ),
            _headerInfo(
              Icons.verified_outlined,
              "Verified Company",
            ),
          ],
        ),
      ],
    );
  }

  Widget _headerInfo(
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _verifiedBadge() {
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
          Icon(
            Icons.verified,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 7),
          Text(
            "Verified",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATS
  // ============================================================

  Widget _companyStats() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool small =
            constraints.maxWidth < 750;

        final List<Widget> cards = [
          _statCard(
            Icons.medication_outlined,
            "Total Medicines",
            "${medicines.length}",
            "Available products",
          ),
          _statCard(
            Icons.favorite_border,
            "Cardiology",
            "4",
            "Medicines",
          ),
          _statCard(
            Icons.bloodtype_outlined,
            "Diabetology",
            "2",
            "Medicines",
          ),
          _statCard(
            Icons.category_outlined,
            "Categories",
            "${categories.length - 1}",
            "Specialties",
          ),
        ];

        if (small) {
          return Column(
            children: [
              for (int i = 0;
              i < cards.length;
              i++) ...[
                cards[i],
                if (i != cards.length - 1)
                  const SizedBox(height: 12),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (int i = 0;
            i < cards.length;
            i++) ...[
              Expanded(
                child: cards[i],
              ),
              if (i != cards.length - 1)
                const SizedBox(width: 14),
            ],
          ],
        );
      },
    );
  }

  Widget _statCard(
      IconData icon,
      String title,
      String value,
      String subtitle,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 25,
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
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                        bottom: 3,
                      ),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
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
  // SEARCH
  // ============================================================

  Widget _searchBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchText = value;
            currentPage = 1;
          });
        },
        decoration: InputDecoration(
          hintText:
          "Search medicine, molecule or category...",
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.search,
              color: AppColors.primary,
            ),
          ),
          suffixIcon: searchText.isNotEmpty
              ? IconButton(
            onPressed: () {
              setState(() {
                searchText = "";
                currentPage = 1;
              });
            },
            icon: const Icon(
              Icons.clear,
            ),
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  Widget _categorySection() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        const Text(
          "Browse by Specialty",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 13),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map(
                  (category) {
                final bool selected =
                    selectedCategory == category;

                return Padding(
                  padding:
                  const EdgeInsets.only(
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory =
                            category;
                        currentPage = 1;
                      });
                    },
                    borderRadius:
                    BorderRadius.circular(30),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : Colors.white,
                        borderRadius:
                        BorderRadius.circular(30),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.black87,
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MEDICINE TITLE
  // ============================================================

  Widget _medicineTitle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                "Available Medicines",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${filteredMedicines.length} medicines found",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        if (filteredMedicines.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Text(
              "Page $currentPage / $totalPages",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // MEDICINE CARD
  // ============================================================

  Widget _medicineCard(
      Map<String, String> medicine,
      ) {
    final String name = medicine["name"]!;
    final String molecule =
    medicine["molecule"]!;
    final String category =
    medicine["category"]!;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.all(18),
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
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool small =
              constraints.maxWidth < 600;

          if (small) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _medicineIcon(),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _medicineInfo(
                        name,
                        molecule,
                        category,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: _viewButton(
                    name,
                    molecule,
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              _medicineIcon(),
              const SizedBox(width: 18),
              Expanded(
                child: _medicineInfo(
                  name,
                  molecule,
                  category,
                ),
              ),
              const SizedBox(width: 20),
              _viewButton(
                name,
                molecule,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _medicineIcon() {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lightTeal,
            Colors.white,
          ],
        ),
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Icon(
        Icons.medication_outlined,
        color: AppColors.primary,
        size: 31,
      ),
    );
  }

  Widget _medicineInfo(
      String name,
      String molecule,
      String category,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          molecule,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightTeal,
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _viewButton(
      String medicine,
      String molecule,
      ) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                MedicineDetailScreen(
                  medicine: medicine,
                  molecule: molecule,
                ),
          ),
        );
      },
      icon: const Icon(
        Icons.arrow_forward,
        size: 17,
      ),
      label: const Text(
        "View Medicine",
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.lightTeal,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              color: AppColors.primary,
              size: 38,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "No medicines found",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            "Try another medicine name or category.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGINATION
  // ============================================================

  Widget _pagination() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment:
        WrapCrossAlignment.center,
        spacing: 7,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: IconButton(
              onPressed: currentPage > 1
                  ? () {
                setState(() {
                  currentPage--;
                });
              }
                  : null,
              icon: const Icon(
                Icons.chevron_left,
              ),
            ),
          ),

          for (
          int page = 1;
          page <= totalPages;
          page++
          )
            InkWell(
              onTap: () {
                setState(() {
                  currentPage = page;
                });
              },
              borderRadius:
              BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: currentPage == page
                      ? AppColors.primary
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(10),
                  border: Border.all(
                    color: currentPage == page
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  "$page",
                  style: TextStyle(
                    color:
                    currentPage == page
                        ? Colors.white
                        : Colors.black87,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: IconButton(
              onPressed:
              currentPage < totalPages
                  ? () {
                setState(() {
                  currentPage++;
                });
              }
                  : null,
              icon: const Icon(
                Icons.chevron_right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}