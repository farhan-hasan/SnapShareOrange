import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:snap_share_orange/presentation/state_holders/forgot_password_screen_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: _buildPasswordRecoveryForm(context),
        ),
      ),
    );
  }

  Widget _buildPasswordRecoveryForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        const Text(
          "Password Recovery",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Enter your e-mail",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: _emailTEController,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 54, 53, 53),
            hintText: 'Email',
            hintStyle: const TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 218, 203, 203)),
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter your email';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<ForgotPasswordScreenController>(
            builder: (forgotPasswordScreenController) {
          return _buildResetEmailButton(forgotPasswordScreenController);
        }),
        const SizedBox(
          height: 40,
        ),
        _buildAccountCreate(context)
      ],
    );
  }

  Widget _buildAccountCreate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Get.to(() => const SignUpScreen());
          },
          child: const Text(
            "Create",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 238, 213, 132),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetEmailButton(
      ForgotPasswordScreenController forgotPasswordScreenController) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: forgotPasswordScreenController.isLoading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  await forgotPasswordScreenController.resetPassword(
                      _emailTEController.text, _emailTEController);
                }
              },
        child: forgotPasswordScreenController.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                "Send Email",
                style: TextStyle(color: Colors.black),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
