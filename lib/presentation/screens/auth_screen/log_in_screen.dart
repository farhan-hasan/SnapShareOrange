import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:snap_share_orange/presentation/widgets/custom_elevated_button.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';
import 'package:snap_share_orange/presentation/widgets/text_validator.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isChecked = false;
  bool _passwordVisible = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  Future<void> _userLogin(String email, String password) async {
    try {
      _isLoading = true;
      setState(() {});
      await FireBaseAuth.signInUserWithEmailAndPassword(email, password);
      if (mounted) {
        ScaffoldMessage.showScafflodMessage(
            context, 'User Login Success', Colors.blueAccent);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavBarScreen()),
            (context) => false);
      }
    } on FirebaseException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'No User Found for that Email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong Password Provided by User';
      } else {
        errorMessage = 'Login Failed: ${e.message}';
      }
      if (mounted) {
        ScaffoldMessage.showScafflodMessage(
            context, errorMessage, Colors.redAccent);
      }
    } catch (e) {
      print("Login Failed: ${e.toString()}");
      if (mounted) {
        ScaffoldMessage.showScafflodMessage(
            context, 'An unexpected error occurred', Colors.redAccent);
      }
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
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
                _buildPasswordForm(),
                const SizedBox(
                  height: 10,
                ),
                _buildCheckBoxPasswordSaved(),
                const SizedBox(
                  height: 30,
                ),
                _buildLoginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomElevatedButton(
      onPressed: _isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                await _userLogin(
                    _emailTEController.text, _passwordTEController.text);
              }
            },
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Log in",
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  Widget _buildCheckBoxPasswordSaved() {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            value: _isChecked,
            onChanged: (value) {
              _changeCheck(value!);
            }),
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

  Widget _buildPasswordForm() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: _passwordTEController,
        obscureText: !_passwordVisible,
        validator: (value) => TextValidator.passwordValidator(value),
        decoration: InputDecoration(
          hintText: 'Input Password',
          prefixIcon: const Icon(Icons.lock),
          suffix: IconButton(
            onPressed: () {
              _tooglePasswordVisible();
            },
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          setState(() {});
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

  void _tooglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    setState(() {});
  }

  void _changeCheck(bool? value) {
    _isChecked = value!;
    setState(() {});
  }
}
