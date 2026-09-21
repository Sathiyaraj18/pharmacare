import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String selectedRole = "mr";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // SIGN UP
  // ============================================================

  Future<void> signup() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword =
    confirmPasswordController.text.trim();

    // -----------------------------
    // Validation
    // -----------------------------

    if (name.isEmpty) {
      showMessage("Please enter your name");
      return;
    }

    if (email.isEmpty) {
      showMessage("Please enter your email");
      return;
    }

    if (password.isEmpty) {
      showMessage("Please enter password");
      return;
    }

    if (password.length < 6) {
      showMessage("Password must contain at least 6 characters");
      return;
    }

    if (confirmPassword.isEmpty) {
      showMessage("Please confirm your password");
      return;
    }

    if (password != confirmPassword) {
      showMessage("Passwords do not match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // ========================================================
      // STEP 1
      // Create Firebase Authentication account
      // ========================================================

      debugPrint("SIGNUP STEP 1: Creating Firebase Auth account...");

      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .timeout(
        const Duration(seconds: 15),
      );

      final User? user = credential.user;

      if (user == null) {
        throw Exception("Firebase user was not created");
      }

      debugPrint("SIGNUP STEP 2: Firebase Auth SUCCESS");
      debugPrint("Firebase UID: ${user.uid}");

      // ========================================================
      // STEP 2
      // Update Firebase user's display name
      // ========================================================

      debugPrint("SIGNUP STEP 3: Updating display name...");

      await user.updateDisplayName(name).timeout(
        const Duration(seconds: 10),
      );

      debugPrint("SIGNUP STEP 4: Display name SUCCESS");

      // ========================================================
      // STEP 3
      // Create Firestore user document
      // ========================================================

      debugPrint("SIGNUP STEP 5: Creating Firestore user document...");

      final Map<String, dynamic> userData = {
        "uid": user.uid,
        "name": name,
        "email": email,
        "role": selectedRole,
        "createdAt": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(userData)
          .timeout(
        const Duration(seconds: 15),
      );

      debugPrint("SIGNUP STEP 6: Firestore SUCCESS");
      debugPrint("Collection: users");
      debugPrint("Document ID: ${user.uid}");
      debugPrint("Role: $selectedRole");

      // ========================================================
      // STEP 4
      // Send verification email
      // ========================================================

      try {
        debugPrint("SIGNUP STEP 7: Sending verification email...");

        await user.sendEmailVerification().timeout(
          const Duration(seconds: 10),
        );

        debugPrint("SIGNUP STEP 8: Verification email sent");
      } catch (e) {
        // Email verification should not prevent account creation.
        debugPrint(
          "Verification email failed, but account was created: $e",
        );
      }

      if (!mounted) return;

      // ========================================================
      // SUCCESS
      // ========================================================

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text("Account Created"),
              ],
            ),
            content: Text(
              "Your $selectedRole account has been created successfully.\n\n"
                  "You can now login using your email and password.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      // Go back to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("SIGNUP AUTH ERROR");
      debugPrint("Code: ${e.code}");
      debugPrint("Message: ${e.message}");

      showMessage(
        e.message ?? "Firebase Authentication error",
      );
    } on FirebaseException catch (e) {
      debugPrint("SIGNUP FIREBASE ERROR");
      debugPrint("Plugin: ${e.plugin}");
      debugPrint("Code: ${e.code}");
      debugPrint("Message: ${e.message}");

      showMessage(
        "Firebase Error:\n${e.message ?? e.code}",
      );
    } catch (e) {
      debugPrint("SIGNUP GENERAL ERROR");
      debugPrint(e.toString());

      showMessage(
        "Signup Error:\n$e",
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f7f7),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(38),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // ==================================================
                // ICON
                // ==================================================

                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xff128078),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff202626),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Create your PharmaCare account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // ==================================================
                // NAME
                // ==================================================

                TextField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Color(0xff128078),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff7f9f9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // EMAIL
                // ==================================================

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xff128078),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff7f9f9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // ROLE
                // ==================================================

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Role",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _roleCard(
                        title: "Medical Representative",
                        value: "mr",
                        icon: Icons.medical_services_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _roleCard(
                        title: "Doctor",
                        value: "doctor",
                        icon: Icons.local_hospital_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // ==================================================
                // PASSWORD
                // ==================================================

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xff128078),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff7f9f9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // CONFIRM PASSWORD
                // ==================================================

                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    if (!isLoading) {
                      signup();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(
                      Icons.lock_reset_outlined,
                      color: Color(0xff128078),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword =
                          !obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff7f9f9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ==================================================
                // SIGNUP BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff128078),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                      const Color(0xff9ac6c2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                      width: 27,
                      height: 27,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // LOGIN
                // ==================================================

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xff128078),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ROLE CARD
  // ============================================================

  Widget _roleCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final bool selected = selectedRole == value;

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: isLoading
          ? null
          : () {
        setState(() {
          selectedRole = value;
        });
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffe5f4f2)
              : const Color(0xfff7f9f9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? const Color(0xff128078)
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? const Color(0xff128078)
                  : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selected
                      ? const Color(0xff128078)
                      : Colors.black87,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Color(0xff128078),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}