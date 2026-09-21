import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/breadcrumb.dart';
import '../../widgets/web_layout.dart';

import 'mr_dashboard.dart';
import 'presentation_screen.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selectedRating = 0;

  final TextEditingController commentController =
  TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  String get ratingTitle {
    switch (selectedRating) {
      case 1:
        return "Very Poor";
      case 2:
        return "Poor";
      case 3:
        return "Good";
      case 4:
        return "Very Good";
      case 5:
        return "Excellent";
      default:
        return "Select a rating";
    }
  }

  String get ratingDescription {
    switch (selectedRating) {
      case 1:
        return "We would like to know what went wrong.";
      case 2:
        return "Your feedback can help us improve.";
      case 3:
        return "Thank you for your feedback.";
      case 4:
        return "Thank you. We are glad you found it useful.";
      case 5:
        return "Excellent! Thank you for your valuable feedback.";
      default:
        return "Please select one of the five stars.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Doctor Review",
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
        BreadcrumbItem(
          title: "Presentations",
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const PresentationScreen(),
              ),
            );
          },
        ),
        const BreadcrumbItem(
          title: "Review",
        ),
      ],
      child: Container(
        width: double.infinity,
        color: const Color(0xffF1F5F5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 700;
            final bool isTablet = constraints.maxWidth < 1050;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 30,
                  vertical: isMobile ? 18 : 28,
                ),
                child: Column(
                  children: [
                    _buildTopHeader(
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildMainContent(
                      isTablet,
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildBottomSection(
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
  // TOP HEADER
  // ============================================================

  Widget _buildTopHeader(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 22 : 30,
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
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSuccessIcon(true),
          const SizedBox(height: 18),
          _buildHeaderText(true),
        ],
      )
          : Row(
        children: [
          _buildSuccessIcon(false),
          const SizedBox(width: 20),
          Expanded(
            child: _buildHeaderText(false),
          ),
          _buildFeedbackBadge(),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon(bool isMobile) {
    return Container(
      height: isMobile ? 60 : 72,
      width: isMobile ? 60 : 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        color: AppColors.primary,
        size: isMobile ? 36 : 44,
      ),
    );
  }

  Widget _buildHeaderText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PRESENTATION COMPLETED",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Doctor Feedback",
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 25 : 31,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          "Please share your experience about the medicine presentation.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.82),
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackBadge() {
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
            Icons.rate_review_outlined,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(height: 6),
          Text(
            "FEEDBACK",
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
  // MAIN CONTENT
  // ============================================================

  Widget _buildMainContent(
      bool isTablet,
      bool isMobile,
      ) {
    if (isTablet) {
      return Column(
        children: [
          _buildPresentationSummary(isMobile),
          const SizedBox(height: 20),
          _buildReviewCard(isMobile),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildPresentationSummary(false),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 7,
          child: _buildReviewCard(false),
        ),
      ],
    );
  }

  // ============================================================
  // PRESENTATION SUMMARY
  // ============================================================

  Widget _buildPresentationSummary(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 26,
      ),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            icon: Icons.slideshow_outlined,
            title: "Presentation Summary",
            subtitle: "Completed session details",
          ),

          const SizedBox(height: 25),

          _summaryItem(
            icon: Icons.medication_outlined,
            title: "Products Presented",
            value: "9 Medicines",
          ),

          _summaryDivider(),

          _summaryItem(
            icon: Icons.category_outlined,
            title: "Therapeutic Divisions",
            value:
            "Cardiology • Diabetology • Orthopedics • Neurology",
          ),

          _summaryDivider(),

          _summaryItem(
            icon: Icons.person_outline,
            title: "Audience",
            value: "Doctor",
          ),

          _summaryDivider(),

          _summaryItem(
            icon: Icons.access_time_outlined,
            title: "Presentation Status",
            value: "Completed",
            valueColor: Colors.green,
          ),

          const SizedBox(height: 24),

          _buildSessionCompletedBox(),
        ],
      ),
    );
  }

  Widget _buildCardTitle({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppColors.lightTeal,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: const Color(0xffF5F9F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 19,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 17,
      ),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildSessionCompletedBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffF5FAF9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.lightTeal,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "Session Completed",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Thank you for taking the time to review the presentation.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    height: 1.5,
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
  // REVIEW CARD
  // ============================================================

  Widget _buildReviewCard(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 28,
      ),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rate This Presentation",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "How useful was the medicine presentation?",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 24),

          _buildRatingBox(isMobile),

          const SizedBox(height: 25),

          const Text(
            "Comments & Feedback",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 9),

          _buildCommentField(),

          const SizedBox(height: 18),

          _buildFeedbackInfo(),

          const SizedBox(height: 20),

          _buildSubmitButton(),
        ],
      ),
    );
  }

  // ============================================================
  // STAR RATING
  // ============================================================

  Widget _buildRatingBox(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: isMobile ? 22 : 28,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          const Text(
            "How would you rate this presentation?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                  (index) {
                final int starNumber = index + 1;
                final bool active =
                    starNumber <= selectedRating;

                return IconButton(
                  tooltip: "$starNumber Star",
                  onPressed: () {
                    setState(() {
                      selectedRating = starNumber;
                    });
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 180,
                    ),
                    child: Icon(
                      active
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      key: ValueKey(
                        "$starNumber-$active",
                      ),
                      size: isMobile ? 40 : 46,
                      color: Colors.amber,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 7),

          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 200,
            ),
            child: Text(
              ratingTitle,
              key: ValueKey(ratingTitle),
              style: TextStyle(
                color: selectedRating == 0
                    ? Colors.grey
                    : AppColors.primary,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 5),

          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 200,
            ),
            child: Text(
              ratingDescription,
              key: ValueKey(ratingDescription),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMENT FIELD
  // ============================================================

  Widget _buildCommentField() {
    return TextField(
      controller: commentController,
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        hintText:
        "Enter your comments or suggestions...",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
        filled: true,
        fillColor: const Color(0xffFAFBFB),

        prefixIcon: const Padding(
          padding: EdgeInsets.only(
            left: 13,
            right: 8,
            bottom: 60,
          ),
          child: Icon(
            Icons.chat_bubble_outline,
            color: AppColors.primary,
            size: 20,
          ),
        ),

        contentPadding: const EdgeInsets.all(16),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FEEDBACK INFORMATION
  // ============================================================

  Widget _buildFeedbackInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xfffff8e7),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: Colors.orange.shade200,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.orange,
            size: 19,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              "Please select a star rating before submitting your review.",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUBMIT BUTTON
  // ============================================================

  Widget _buildSubmitButton() {
    final bool enabled = selectedRating > 0;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: enabled
            ? _submitReview
            : null,
        icon: const Icon(
          Icons.send_rounded,
          size: 19,
        ),
        label: const Text(
          "SUBMIT REVIEW",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor:
          Colors.grey.shade300,
          disabledForegroundColor:
          Colors.grey.shade600,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM SECTION
  // ============================================================

  Widget _buildBottomSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: isMobile
          ? Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _backToPresentation,
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
              label: const Text(
                "Back to Presentation",
              ),
              style: OutlinedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                foregroundColor:
                AppColors.primary,
                side: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildSecureText(),
        ],
      )
          : Row(
        children: [
          OutlinedButton.icon(
            onPressed: _backToPresentation,
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
            label: const Text(
              "Back to Presentation",
            ),
            style: OutlinedButton.styleFrom(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              foregroundColor:
              AppColors.primary,
              side: const BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
          const Spacer(),
          _buildSecureText(),
        ],
      ),
    );
  }

  Widget _buildSecureText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          size: 15,
          color: Colors.grey,
        ),
        SizedBox(width: 6),
        Text(
          "Doctor feedback is handled securely",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SUBMIT REVIEW
  // ============================================================

  void _submitReview() {
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          contentPadding:
          const EdgeInsets.fromLTRB(
            25,
            28,
            25,
            20,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: const Color(0xffEAF7F4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.primary,
                  size: 38,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Review Submitted",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Thank you for sharing your valuable feedback.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) {
                    return Icon(
                      index < selectedRating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 26,
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const MRDashboard(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(11),
                    ),
                  ),
                  child: const Text(
                    "BACK TO DASHBOARD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // BACK TO PRESENTATION
  // ============================================================

  void _backToPresentation() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PresentationScreen(),
      ),
    );
  }

  // ============================================================
  // CARD STYLE
  // ============================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey.shade200,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 18,
          offset: const Offset(0, 7),
        ),
      ],
    );
  }
}