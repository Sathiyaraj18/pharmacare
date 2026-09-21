import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';

import 'selected_doctors_screen.dart';

class MRDoctorsScreen extends StatefulWidget {
  const MRDoctorsScreen({super.key});

  @override
  State<MRDoctorsScreen> createState() => _MRDoctorsScreenState();
}

class _MRDoctorsScreenState extends State<MRDoctorsScreen> {
  // ============================================================
  // SELECTION
  // ============================================================

  final Set<String> selectedDoctors = {};

  // ============================================================
  // SEARCH
  // ============================================================

  String searchText = "";

  // ============================================================
  // PAGINATION
  // ============================================================

  int currentPage = 1;

  final int itemsPerPage = 4;

  // ============================================================
  // DOCTOR DATA
  // ============================================================

  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Kumar",
      "specialty": "Cardiology",
      "hospital": "ABC Hospital",
      "location": "Chennai",
      "phone": "9876543210",
      "email": "kumar@abchospital.com",
    },
    {
      "name": "Dr. Ravi",
      "specialty": "Cardiology",
      "hospital": "City Hospital",
      "location": "Chennai",
      "phone": "9876543211",
      "email": "ravi@cityhospital.com",
    },
    {
      "name": "Dr. Arun",
      "specialty": "Cardiology",
      "hospital": "Apollo Hospital",
      "location": "Chennai",
      "phone": "9876543212",
      "email": "arun@apollo.com",
    },
    {
      "name": "Dr. Suresh",
      "specialty": "Diabetology",
      "hospital": "Global Hospital",
      "location": "Chennai",
      "phone": "9876543213",
      "email": "suresh@globalhospital.com",
    },
    {
      "name": "Dr. Priya",
      "specialty": "Neurology",
      "hospital": "Fortis Hospital",
      "location": "Chennai",
      "phone": "9876543214",
      "email": "priya@fortis.com",
    },
    {
      "name": "Dr. Anitha",
      "specialty": "Cardiology",
      "hospital": "MIOT Hospital",
      "location": "Chennai",
      "phone": "9876543215",
      "email": "anitha@miot.com",
    },
    {
      "name": "Dr. Raj",
      "specialty": "Orthopedics",
      "hospital": "Kauvery Hospital",
      "location": "Chennai",
      "phone": "9876543216",
      "email": "raj@kauvery.com",
    },
    {
      "name": "Dr. Manoj",
      "specialty": "Cardiology",
      "hospital": "Vijaya Hospital",
      "location": "Chennai",
      "phone": "9876543217",
      "email": "manoj@vijaya.com",
    },
    {
      "name": "Dr. Vijay",
      "specialty": "Diabetology",
      "hospital": "Sri Ramachandra Hospital",
      "location": "Chennai",
      "phone": "9876543218",
      "email": "vijay@srh.com",
    },
    {
      "name": "Dr. Karthik",
      "specialty": "Cardiology",
      "hospital": "Gleneagles Hospital",
      "location": "Chennai",
      "phone": "9876543219",
      "email": "karthik@gleneagles.com",
    },
    {
      "name": "Dr. Meena",
      "specialty": "Neurology",
      "hospital": "SIMS Hospital",
      "location": "Chennai",
      "phone": "9876543220",
      "email": "meena@sims.com",
    },
    {
      "name": "Dr. Sanjay",
      "specialty": "Cardiology",
      "hospital": "MGM Healthcare",
      "location": "Chennai",
      "phone": "9876543221",
      "email": "sanjay@mgm.com",
    },
  ];

  // ============================================================
  // FILTERED DOCTORS
  // ============================================================

  List<Map<String, String>> get filteredDoctors {
    final String search = searchText.trim().toLowerCase();

    if (search.isEmpty) {
      return doctors;
    }

    return doctors.where((doctor) {
      return doctor["name"]!
          .toLowerCase()
          .contains(search) ||
          doctor["specialty"]!
              .toLowerCase()
              .contains(search) ||
          doctor["hospital"]!
              .toLowerCase()
              .contains(search) ||
          doctor["location"]!
              .toLowerCase()
              .contains(search) ||
          doctor["phone"]!
              .toLowerCase()
              .contains(search) ||
          doctor["email"]!
              .toLowerCase()
              .contains(search);
    }).toList();
  }

  // ============================================================
  // TOTAL PAGES
  // ============================================================

  int get totalPages {
    if (filteredDoctors.isEmpty) {
      return 1;
    }

    return (filteredDoctors.length / itemsPerPage).ceil();
  }

  // ============================================================
  // PAGINATED DOCTORS
  // ============================================================

  List<Map<String, String>> get paginatedDoctors {
    final List<Map<String, String>> list = filteredDoctors;

    if (list.isEmpty) {
      return [];
    }

    int startIndex = (currentPage - 1) * itemsPerPage;

    if (startIndex >= list.length) {
      startIndex = 0;
    }

    int endIndex = startIndex + itemsPerPage;

    if (endIndex > list.length) {
      endIndex = list.length;
    }

    return list.sublist(startIndex, endIndex);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Doctors",
      menu: "mr",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),

            const SizedBox(height: 25),

            _selectionCard(),

            const SizedBox(height: 25),

            _searchAndAddSection(),

            const SizedBox(height: 30),

            _doctorSection(),

            const SizedBox(height: 20),

            if (filteredDoctors.isNotEmpty) _pagination(),

            const SizedBox(height: 20),

            _bottomButton(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.people_alt_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Doctor Management",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  "Add, edit, delete and manage doctors assigned to your territory",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Cardiology Division • Chennai",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
  // SELECTION CARD
  // ============================================================

  Widget _selectionCard() {
    final bool minimumReached = selectedDoctors.length >= 7;

    final double progress = selectedDoctors.length / 10;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Doctor Selection",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                "${selectedDoctors.length} / 10",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                minimumReached
                    ? Colors.green
                    : AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            minimumReached
                ? "Minimum selection completed"
                : "Select at least 7 doctors to continue",
            style: TextStyle(
              color: minimumReached
                  ? Colors.green
                  : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH + ADD BUTTON
  // ============================================================

  Widget _searchAndAddSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 700;

        if (isSmall) {
          return Column(
            children: [
              _searchField(),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: _addDoctorButton(),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _searchField(),
            ),

            const SizedBox(width: 15),

            _addDoctorButton(),
          ],
        );
      },
    );
  }

  // ============================================================
  // SEARCH FIELD
  // ============================================================

  Widget _searchField() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          "Search doctor, specialty, hospital, phone or email",
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primary,
          ),
          suffixIcon: searchText.isNotEmpty
              ? IconButton(
            onPressed: () {
              setState(() {
                searchText = "";
                currentPage = 1;
              });
            },
            icon: const Icon(Icons.clear),
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ADD DOCTOR BUTTON
  // ============================================================

  Widget _addDoctorButton() {
    return ElevatedButton.icon(
      onPressed: () {
        _showDoctorDialog();
      },
      icon: const Icon(Icons.add),
      label: const Text("Add Doctor"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // DOCTOR SECTION
  // ============================================================

  Widget _doctorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "Available Doctors",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (filteredDoctors.isNotEmpty)
              Text(
                "Page $currentPage of $totalPages",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
          ],
        ),

        const SizedBox(height: 15),

        if (paginatedDoctors.isEmpty)
          _emptyState()
        else
          ...paginatedDoctors.map(
                (doctor) => _doctorCard(doctor),
          ),
      ],
    );
  }

  // ============================================================
  // DOCTOR CARD
  // ============================================================

  Widget _doctorCard(
      Map<String, String> doctor,
      ) {
    final String name = doctor["name"]!;

    final bool selected = selectedDoctors.contains(name);

    final bool canSelect = selectedDoctors.length < 10;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.lightTeal
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? AppColors.primary
              : Colors.grey.shade200,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          _toggleDoctor(
            name,
            selected,
            canSelect,
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              // ==================================================
              // DOCTOR ICON
              // ==================================================

              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary
                      : AppColors.lightTeal,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: selected
                      ? Colors.white
                      : AppColors.primary,
                  size: 30,
                ),
              ),

              const SizedBox(width: 15),

              // ==================================================
              // DOCTOR INFORMATION
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      doctor["specialty"]!,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      doctor["hospital"]!,
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
                          size: 15,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          doctor["location"]!,
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

              const SizedBox(width: 10),

              // ==================================================
              // ACTION BUTTONS
              // ==================================================

              Column(
                children: [
                  // EDIT
                  IconButton(
                    tooltip: "Edit Doctor",
                    onPressed: () {
                      _showDoctorDialog(
                        doctor: doctor,
                      );
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: AppColors.primary,
                    ),
                  ),

                  // DELETE
                  IconButton(
                    tooltip: "Delete Doctor",
                    onPressed: () {
                      _showDeleteDialog(doctor);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),

                  // SELECT
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Icon(
                      selected
                          ? Icons.check
                          : Icons.add,
                      color: selected
                          ? Colors.white
                          : (canSelect
                          ? AppColors.primary
                          : Colors.grey),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SELECT / UNSELECT DOCTOR
  // ============================================================

  void _toggleDoctor(
      String doctor,
      bool selected,
      bool canSelect,
      ) {
    setState(() {
      if (selected) {
        selectedDoctors.remove(doctor);
      } else if (canSelect) {
        selectedDoctors.add(doctor);
      }
    });
  }

  // ============================================================
  // ADD / EDIT DOCTOR DIALOG
  // ============================================================

  void _showDoctorDialog({
    Map<String, String>? doctor,
  }) {
    final bool isEdit = doctor != null;

    final nameController = TextEditingController(
      text: doctor?["name"] ?? "",
    );

    final specialtyController = TextEditingController(
      text: doctor?["specialty"] ?? "",
    );

    final hospitalController = TextEditingController(
      text: doctor?["hospital"] ?? "",
    );

    final locationController = TextEditingController(
      text: doctor?["location"] ?? "",
    );

    final phoneController = TextEditingController(
      text: doctor?["phone"] ?? "",
    );

    final emailController = TextEditingController(
      text: doctor?["email"] ?? "",
    );

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                isEdit
                    ? Icons.edit_outlined
                    : Icons.person_add_outlined,
                color: AppColors.primary,
              ),

              const SizedBox(width: 10),

              Text(
                isEdit
                    ? "Edit Doctor"
                    : "Add Doctor",
              ),
            ],
          ),

          content: SizedBox(
            width: 520,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _formField(
                      controller: nameController,
                      label: "Doctor Name",
                      hint: "Enter doctor name",
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 15),

                    _formField(
                      controller: specialtyController,
                      label: "Specialty",
                      hint: "Enter specialty",
                      icon: Icons.medical_information_outlined,
                    ),

                    const SizedBox(height: 15),

                    _formField(
                      controller: hospitalController,
                      label: "Hospital",
                      hint: "Enter hospital name",
                      icon: Icons.local_hospital_outlined,
                    ),

                    const SizedBox(height: 15),

                    _formField(
                      controller: locationController,
                      label: "Location",
                      hint: "Enter location",
                      icon: Icons.location_on_outlined,
                    ),

                    const SizedBox(height: 15),

                    _formField(
                      controller: phoneController,
                      label: "Phone",
                      hint: "Enter phone number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 15),

                    _formField(
                      controller: emailController,
                      label: "Email",
                      hint: "Enter email address",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton.icon(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                final String newName =
                nameController.text.trim();

                // Prevent duplicate doctor names
                if (!isEdit) {
                  final bool duplicate = doctors.any(
                        (item) =>
                    item["name"]!.toLowerCase() ==
                        newName.toLowerCase(),
                  );

                  if (duplicate) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Doctor already exists",
                        ),
                      ),
                    );

                    return;
                  }
                }

                setState(() {
                  if (isEdit) {
                    // =========================================
                    // UPDATE EXISTING DOCTOR
                    // =========================================

                    final String oldName =
                    doctor["name"]!;

                    doctor["name"] = newName;
                    doctor["specialty"] =
                        specialtyController.text.trim();
                    doctor["hospital"] =
                        hospitalController.text.trim();
                    doctor["location"] =
                        locationController.text.trim();
                    doctor["phone"] =
                        phoneController.text.trim();
                    doctor["email"] =
                        emailController.text.trim();

                    // Update selected doctor name
                    // if doctor name was changed.
                    if (selectedDoctors.contains(oldName)) {
                      selectedDoctors.remove(oldName);
                      selectedDoctors.add(newName);
                    }
                  } else {
                    // =========================================
                    // INSERT NEW DOCTOR
                    // =========================================

                    doctors.add({
                      "name": newName,
                      "specialty":
                      specialtyController.text.trim(),
                      "hospital":
                      hospitalController.text.trim(),
                      "location":
                      locationController.text.trim(),
                      "phone":
                      phoneController.text.trim(),
                      "email":
                      emailController.text.trim(),
                    });
                  }

                  currentPage = 1;
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      isEdit
                          ? "Doctor updated successfully"
                          : "Doctor added successfully",
                    ),
                  ),
                );
              },
              icon: Icon(
                isEdit ? Icons.save : Icons.add,
              ),
              label: Text(
                isEdit ? "Update" : "Add Doctor",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // FORM FIELD
  // ============================================================

  Widget _formField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label is required";
        }

        if (label == "Phone" &&
            value.trim().length < 10) {
          return "Enter a valid phone number";
        }

        if (label == "Email" &&
            !value.contains("@")) {
          return "Enter a valid email";
        }

        return null;
      },
    );
  }

  // ============================================================
  // DELETE CONFIRMATION
  // ============================================================

  void _showDeleteDialog(
      Map<String, String> doctor,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),

              SizedBox(width: 10),

              Text("Delete Doctor"),
            ],
          ),

          content: Text(
            "Are you sure you want to delete ${doctor["name"]}?",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  final String doctorName =
                  doctor["name"]!;

                  // Remove from doctor list
                  doctors.remove(doctor);

                  // Remove from selected list
                  selectedDoctors.remove(doctorName);

                  // Fix pagination
                  if (currentPage > totalPages) {
                    currentPage = totalPages;
                  }
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Doctor deleted successfully",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.delete),
              label: const Text("Delete"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
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
        spacing: 6,
        children: [
          // Previous
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
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

          // Page numbers
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
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: currentPage == page
                      ? AppColors.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: currentPage == page
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  "$page",
                  style: TextStyle(
                    color: currentPage == page
                        ? Colors.white
                        : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Next
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: IconButton(
              onPressed: currentPage < totalPages
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

  // ============================================================
  // BOTTOM BUTTON
  // ============================================================

  Widget _bottomButton() {
    final bool enabled = selectedDoctors.length >= 7;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  enabled
                      ? "Ready to continue"
                      : "Doctor selection",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  enabled
                      ? "${selectedDoctors.length} doctors selected"
                      : "Select minimum 7 doctors",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          ElevatedButton.icon(
            onPressed: enabled
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SelectedDoctorsScreen(
                        doctors:
                        selectedDoctors.toList(),
                      ),
                ),
              );
            }
                : null,
            icon: const Icon(
              Icons.arrow_forward,
              size: 18,
            ),
            label: Text(
              enabled
                  ? "Continue"
                  : "Select Minimum 7",
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
              Colors.grey.shade300,
              disabledForegroundColor:
              Colors.grey.shade600,
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 55,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          const Text(
            "No doctors found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            "Try another search or add a new doctor.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}