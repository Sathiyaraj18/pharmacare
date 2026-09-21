import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final emailController =
  TextEditingController();

  bool isLoading = false;
  bool emailSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    final email =
    emailController.text.trim();

    if (email.isEmpty) {
      _showMessage(
        "Please enter your email address.",
      );
      return;
    }

    if (!email.contains("@")) {
      _showMessage(
        "Please enter a valid email address.",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      )
          .timeout(
        const Duration(seconds: 15),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
        emailSent = true;
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      String message;

      switch (e.code) {
        case "user-not-found":
          message =
          "No account found with this email.";
          break;

        case "invalid-email":
          message =
          "Please enter a valid email address.";
          break;

        case "network-request-failed":
          message =
          "Network error. Please check your internet connection.";
          break;

        default:
          message =
              e.message ??
                  "Unable to send reset email.";
      }

      _showMessage(message);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        "Error: $e",
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior:
        SnackBarBehavior.floating,
        duration:
        const Duration(seconds: 5),
        content: Text(message),
      ),
    );
  }

  void _backToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xffF1F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(
              maxWidth: 450,
            ),
            child: Container(
              padding:
              const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.06),
                    blurRadius: 20,
                    offset:
                    const Offset(0, 8),
                  ),
                ],
              ),
              child: emailSent
                  ? _buildSuccessView()
                  : _buildForgotView(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotView() {
    return Column(
      children: [
        _buildHeader(),

        const SizedBox(height: 30),

        Align(
          alignment:
          Alignment.centerLeft,
          child: const Text(
            "Email Address",
            style: TextStyle(
              fontSize: 13,
              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: emailController,
          keyboardType:
          TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText:
            "Enter your registered email",
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: AppColors.primary,
            ),
            filled: true,
            fillColor:
            const Color(0xffF8FAFA),
            border:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(12),
              borderSide:
              BorderSide.none,
            ),
            enabledBorder:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                Colors.grey.shade200,
              ),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(12),
              borderSide:
              const BorderSide(
                color:
                AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color:
            const Color(0xfffff8e7),
            borderRadius:
            BorderRadius.circular(12),
            border: Border.all(
              color:
              Colors.orange.shade200,
            ),
          ),
          child: const Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.orange,
                size: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "A password reset link will be sent to your registered email address.",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed:
            isLoading
                ? null
                : _sendResetEmail,
            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              AppColors.primary,
              foregroundColor:
              Colors.white,
              elevation: 0,
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12),
              ),
            ),
            child: isLoading
                ? const SizedBox(
              height: 22,
              width: 22,
              child:
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
                : const Text(
              "SEND RESET LINK",
              style: TextStyle(
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        TextButton.icon(
          onPressed: isLoading
              ? null
              : _backToLogin,
          icon: const Icon(
            Icons.arrow_back,
          ),
          label: const Text(
            "Back to Login",
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration:
          const BoxDecoration(
            color: Color(0xffEAF7F4),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons
                .mark_email_read_outlined,
            color: AppColors.primary,
            size: 40,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Reset Link Sent",
          style: TextStyle(
            fontSize: 25,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "We have sent a password reset link to:",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          emailController.text.trim(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color:
            const Color(0xffF5FAF9),
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: const Column(
            children: [
              Icon(
                Icons
                    .mark_email_unread_outlined,
                color:
                AppColors.primary,
                size: 25,
              ),
              SizedBox(height: 8),
              Text(
                "Check your inbox",
                style: TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Open the email and click the password reset link to create a new password.",
                textAlign:
                TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _backToLogin,
            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              AppColors.primary,
              foregroundColor:
              Colors.white,
              elevation: 0,
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "BACK TO LOGIN",
              style: TextStyle(
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        TextButton(
          onPressed: () {
            setState(() {
              emailSent = false;
            });
          },
          child: const Text(
            "Try another email",
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.lock_reset_outlined,
            color: Colors.white,
            size: 36,
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 26,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          "Reset your PharmaCare password",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}