import 'package:attendance_apk/views/auth/verify_code.dart';
import 'package:flutter/material.dart';
import '../../sevices/api_service.dart';
import '../../constants/app_colors.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await ApiService.forgotPassword(
      _emailController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (!mounted) return;
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent!")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => VerifyCodeView(email: _emailController.text.trim()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? "Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customDarkBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter your registered email address\nto reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 32),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (v) => v == null || v.isEmpty ? "Enter your email" : null,
                ),
                const SizedBox(height: 28),

                // Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimary,
                        ),
                        onPressed: _handleReset,
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Back to Login",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.customGreen,
                      fontWeight: FontWeight.w500,
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
