import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/presentation/state_holders/sign_up_screen_controller.dart';
import 'package:snap_share_orange/presentation/widgets/custom_elevated_button.dart';
import 'package:snap_share_orange/presentation/widgets/text_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body:
          GetBuilder<SignUpScreenController>(builder: (signUpScreenController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Inter your Name, Email and Password",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Name"),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildNameForm(),
                  const Text("Email"),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildEmailForm(),
                  const Text("Password"),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildPasswordForm(signUpScreenController),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSignUpButton(signUpScreenController)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSignUpButton(SignUpScreenController signUpController) {
    return CustomElevatedButton(
      onPressed: signUpController.isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                await signUpController.createUserSignUpDatabase(
                    _emailTEController.text,
                    _passwordTEController.text,
                    _nameTEController.text);
              }
            },
      child: signUpController.isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  Widget _buildPasswordForm(SignUpScreenController signUpController) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: _passwordTEController,
        obscureText: !signUpController.passwordVisible,
        validator: (value) => TextValidator.passwordValidator(value),
        decoration: InputDecoration(
          hintText: 'Input Password',
          prefixIcon: const Icon(Icons.lock),
          suffix: IconButton(
            onPressed: () {
              signUpController.tooglePasswordVisible();
            },
            icon: Icon(signUpController.passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          signUpController.onChangedValue();
        },
      ),
    );
  }

  Widget _buildNameForm() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: _nameTEController,
        decoration: InputDecoration(
          hintText: 'Input Name',
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) => TextValidator.textValidator(value),
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
