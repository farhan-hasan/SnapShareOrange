import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/forgot_password_screen.dart';
import 'package:snap_share_orange/presentation/state_holders/log_in_screen_controller.dart';
import 'package:snap_share_orange/presentation/widgets/custom_elevated_button.dart';
import 'package:snap_share_orange/presentation/widgets/text_validator.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: GetBuilder<LogInScreenController>(builder: (logInScreenController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Inter your Email and Password",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Email"),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildEmailForm(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Password"),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildPasswordForm(logInScreenController),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildCheckBoxPasswordSaved(logInScreenController),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildLoginButton(logInScreenController),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: const Text('Forgot Password?'))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoginButton(LogInScreenController logInScreenController) {
    return CustomElevatedButton(
      onPressed: logInScreenController.inProgress
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                await logInScreenController.userLogin(
                    _emailTEController.text, _passwordTEController.text);
              }
            },
      child: logInScreenController.inProgress
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Log in",
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  Widget _buildCheckBoxPasswordSaved(
      LogInScreenController logInScreenController) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: logInScreenController.isChecked,
          onChanged: (value) {
            logInScreenController.changeCheck(
              value,
            );
          },
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          "Save password",
          style: TextStyle(fontSize: 12, color: Colors.black),
        )
      ],
    );
  }

  Widget _buildPasswordForm(LogInScreenController logInScreenController) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: _passwordTEController,
        obscureText: !logInScreenController.passwordVisible,
        validator: (value) => TextValidator.passwordValidator(value),
        decoration: InputDecoration(
          hintText: 'Input Password',
          prefixIcon: const Icon(Icons.lock),
          suffix: IconButton(
            onPressed: () {
              logInScreenController.togglePasswordVisible();
            },
            icon: Icon(logInScreenController.passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          logInScreenController.onChangedValue();
        },
      ),
    );
  }

  Widget _buildEmailForm() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: _emailTEController,
        decoration: InputDecoration(
          hintText: 'Input Email',
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) => TextValidator.textValidator(value),
      ),
    );
  }
}
