import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../doctor/doctor_dashboard.dart';
import '../mr/mr_dashboard.dart';

import 'forget_password_screen.dart' show ForgotPasswordScreen;
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      showMessage("Please enter email address");
      return;
    }

    if (password.isEmpty) {
      showMessage("Please enter password");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      debugPrint("STEP 1: Starting Firebase Authentication...");

      // ---------------------------------------------------------
      // STEP 1: Firebase Authentication
      // ---------------------------------------------------------
      final UserCredential credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).timeout(
        const Duration(seconds: 10),
      );

      debugPrint("STEP 2: Firebase Authentication SUCCESS");

      final User? user = credential.user;

      if (user == null) {
        throw Exception("Firebase user is null");
      }

      debugPrint("UID: ${user.uid}");
      debugPrint("Email: ${user.email}");

      // ---------------------------------------------------------
      // STEP 2: Firestore
      // ---------------------------------------------------------
      debugPrint("STEP 3: Starting Firestore request...");

      final DocumentSnapshot<Map<String, dynamic>> document =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(
        const Duration(seconds: 10),
      );

      debugPrint("STEP 4: Firestore request SUCCESS");

      if (!document.exists) {
        await FirebaseAuth.instance.signOut();

        showMessage(
          "Login successful, but user profile was not found in Firestore.",
        );

        return;
      }

      final data = document.data();

      debugPrint("Firestore data: $data");

      final String role =
      (data?['role'] ?? '').toString().toLowerCase().trim();

      debugPrint("USER ROLE: $role");

      if (!mounted) return;

      // ---------------------------------------------------------
      // STEP 3: Navigate according to role
      // ---------------------------------------------------------

      if (role == "mr") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MRDashboard(),
          ),
        );
      } else if (role == "doctor") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DoctorDashboard(),
          ),
        );
      } else {
        await FirebaseAuth.instance.signOut();

        showMessage(
          "Invalid user role: $role",
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("AUTH ERROR");
      debugPrint("Code: ${e.code}");
      debugPrint("Message: ${e.message}");

      showMessage(
        "Firebase Auth Error:\n${e.message ?? e.code}",
      );
    } on FirebaseException catch (e) {
      debugPrint("FIREBASE ERROR");
      debugPrint("Plugin: ${e.plugin}");
      debugPrint("Code: ${e.code}");
      debugPrint("Message: ${e.message}");

      showMessage(
        "Firebase Error:\n${e.message ?? e.code}",
      );
    } catch (e) {
      debugPrint("GENERAL ERROR");
      debugPrint(e.toString());

      showMessage(
        "Error:\n$e",
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f7f7),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 565,
            padding: const EdgeInsets.fromLTRB(38, 38, 38, 32),
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
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: const Color(0xff128078),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.medical_services_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "PharmaCare",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff202626),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 38),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
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

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xff128078),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff128078),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: isLoading
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_add_alt_1,
                      color: Color(0xff128078),
                    ),
                    label: const Text(
                      "CREATE NEW ACCOUNT",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff128078),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff7d8585),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}